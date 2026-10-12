section Section1;

shared raw_data = let
    Source = Csv.Document(
        Web.Contents(
            "https://raw.githubusercontent.com/jrcinco/supply-chain-shipment-price-data/master/SCMS_Delivery_History_Dataset.csv"
        ),
        [Delimiter=",", Encoding=65001, QuoteStyle=QuoteStyle.Csv]
    ),
    Headers = Table.PromoteHeaders(Source, [PromoteAllScalars=true])
in
    Headers;

shared ARV_Clean_Data = let
    Source = raw_data,
    #"Filtered Rows2" = Table.SelectRows(Source, each ([Country] = "Burundi" or [Country] = "Ethiopia" or [Country] = "Kenya" or [Country] = "Rwanda" or [Country] = "South Sudan" or [Country] = "Tanzania" or [Country] = "Uganda")),
    #"Filtered Rows" = Table.SelectRows(#"Filtered Rows2", each ([Product Group] = "ARV")),
    #"Removed Other Columns" = Table.SelectColumns(#"Filtered Rows",{"ID", "PO / SO #", "ASN/DN #", "Country", "Fulfill Via", "Vendor INCO Term", "Shipment Mode", "PO Sent to Vendor Date", "Scheduled Delivery Date", "Delivered to Client Date", "Delivery Recorded Date", "Product Group", "Sub Classification", "Vendor", "Item Description", "Molecule/Test Type", "Brand", "Dosage", "Dosage Form", "Unit of Measure (Per Pack)", "Line Item Quantity", "Line Item Value", "Pack Price", "Unit Price", "Weight (Kilograms)", "Freight Cost (USD)"}),
    #"Reordered Columns" = Table.ReorderColumns(#"Removed Other Columns",{"ID", "PO / SO #", "ASN/DN #", "Country", "Product Group", "Sub Classification", "Vendor", "Fulfill Via", "Vendor INCO Term", "Shipment Mode", "PO Sent to Vendor Date", "Scheduled Delivery Date", "Delivered to Client Date", "Delivery Recorded Date", "Item Description", "Molecule/Test Type", "Brand", "Dosage", "Dosage Form", "Unit of Measure (Per Pack)", "Line Item Quantity", "Line Item Value", "Pack Price", "Unit Price", "Weight (Kilograms)", "Freight Cost (USD)"}),
    #"Changed Type" = Table.TransformColumnTypes(#"Reordered Columns",{{"ID", Int64.Type}}),
    #"Trimmed Text" = Table.TransformColumns(#"Changed Type",{{"PO / SO #", Text.Trim, type text}, {"ASN/DN #", Text.Trim, type text}, {"Country", Text.Trim, type text}, {"Product Group", Text.Trim, type text}, {"Sub Classification", Text.Trim, type text}, {"Vendor", Text.Trim, type text}, {"Fulfill Via", Text.Trim, type text}, {"Vendor INCO Term", Text.Trim, type text}, {"Shipment Mode", Text.Trim, type text}, {"PO Sent to Vendor Date", Text.Trim, type text}}),
    #"Changed Type1" = Table.TransformColumnTypes(#"Trimmed Text",{{"Scheduled Delivery Date", type date}, {"Delivered to Client Date", type date}, {"Delivery Recorded Date", type date}}),
    #"Trimmed Text1" = Table.TransformColumns(#"Changed Type1",{{"Item Description", Text.Trim, type text}, {"Molecule/Test Type", Text.Trim, type text}, {"Brand", Text.Trim, type text}, {"Dosage", Text.Trim, type text}, {"Dosage Form", Text.Trim, type text}}),
    #"Trimmed Text2" = Table.TransformColumns(#"Trimmed Text1",{{"Item Description", Text.Trim, type text}, {"Molecule/Test Type", Text.Trim, type text}, {"Brand", Text.Trim, type text}, {"Dosage", Text.Trim, type text}, {"Dosage Form", Text.Trim, type text}}),
    #"Changed Type2" = Table.TransformColumnTypes(#"Trimmed Text2",{{"Weight (Kilograms)", type number}}),
    #"Replaced Errors" = Table.ReplaceErrorValues(#"Changed Type2", {{"Weight (Kilograms)", null}}),
    #"Changed Type3" = Table.TransformColumnTypes(#"Replaced Errors",{{"Freight Cost (USD)", type number}}),
    #"Replaced Errors1" = Table.ReplaceErrorValues(#"Changed Type3", {{"Freight Cost (USD)", null}}),
    #"Trimmed Text3" = Table.TransformColumns(#"Replaced Errors1",{{"PO Sent to Vendor Date", Text.Trim, type text}}),
    #"Changed Type with Locale" = Table.TransformColumnTypes(#"Trimmed Text3", {{"PO Sent to Vendor Date", type date}}, "en-US"),
    #"Replaced Errors2" = Table.ReplaceErrorValues(#"Changed Type with Locale", {{"PO Sent to Vendor Date", null}}),
    #"Changed Type4" = Table.TransformColumnTypes(#"Replaced Errors2",{{"Unit of Measure (Per Pack)", type number}, {"Line Item Quantity", Int64.Type}, {"Line Item Value", type number}, {"Unit Price", type number}, {"Pack Price", type number}}),
    #"Filtered Rows1" = Table.SelectRows(#"Changed Type4", each true),
    #"Added Custom" = Table.AddColumn(#"Filtered Rows1", "On_time_flag", each if [Delivered to Client Date] <= [Scheduled Delivery Date] then 1 else 0),
    #"Duplicated Column" = Table.DuplicateColumn(#"Added Custom", "Delivery Recorded Date", "Delivery Recorded Date - Copy"),
    #"Extracted Year" = Table.TransformColumns(#"Duplicated Column",{{"Delivery Recorded Date - Copy", Date.Year, Int64.Type}})
in
    #"Extracted Year";