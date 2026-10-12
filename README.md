# ARV Supply Chain Performance Analytics | East Africa (2006–2015)

An independent Excel-based analysis of historical ARV medicine shipment records, focusing on **timely delivery**, **reasonable procurement cost**, and **reliable supply** across seven East African countries.

> **Portfolio disclaimer:** This is an independent analytics project, not an official USAID report or endorsement. Results reflect a filtered historical dataset and do not describe current USAID operations.

## Business questions

1. **Timely delivery:** How often did ARV deliveries arrive on or before the scheduled date?
2. **Reasonable procurement cost:** How did recorded prices for equivalent ARV products change over time?
3. **Reliable supply:** What do delivery performance and distribution-channel concentration reveal about potential supply vulnerabilities?

## Project scope and tools

| Dimension | Detail |
| --- | --- |
| Years analysed | 2006–2015 |
| Countries | Burundi, Ethiopia, Kenya, Rwanda, South Sudan, Tanzania, Uganda |
| Product group | Antiretroviral medicines (ARVs) |
| Source observations | 1,753 product line items |
| Delivery-level observations | 1,330 unique ASN/DN delivery references |
| Recorded commodity value | US$282.65 million |
| Tools | Microsoft Excel, Power Query, PivotTables, formulas, charts, conditional formatting, Form Controls |

**Original raw dataset:** [SCMS Delivery History Dataset (CSV)](https://github.com/jrcinco/supply-chain-shipment-price-data/blob/master/SCMS_Delivery_History_Dataset.csv), sourced through the workbook's Power Query `raw_data` query. **Exact source and transformation script:** [`power_query/Section1.m`](power_query/Section1.m). This script was extracted from the workbook's embedded Power Query mashup, not recreated.

## Findings at a glance

| Area | Finding |
| --- | --- |
| Overall timeliness | **86.92% on-time delivery** (1,156 of 1,330 deliveries); 174 were late (13.08%) |
| Late-delivery severity | Average delay **21.49 days**; median delay **12 days** |
| Fulfillment reliability | Direct Drop **97.03%** on time vs From RDC **81.95%** |
| Country comparison | Burundi **48.57%** on time across 35 deliveries; Rwanda **91.09%** across 303 |
| Procurement-price trend | Efavirenz 600 mg, 30 tablets: weighted pack price **$16.75 in 2006** to **$3.16 in 2015** |
| Supply concentration | From RDC represented **70.22% of recorded commodity value** and **92.53% of late deliveries** |

## Data and reproducibility

- [Original raw-data CSV](https://github.com/jrcinco/supply-chain-shipment-price-data/blob/master/SCMS_Delivery_History_Dataset.csv) — the publicly hosted unfiltered dataset loaded by Power Query; linked rather than duplicated here.
- [Exact Power Query M script](power_query/Section1.m) — includes the `raw_data` download query and `ARV_Clean_Data` cleaning query (seven-country and ARV filters, field selection, type conversion, date handling, and derived fields).
- [Completed Excel workbook](USAID%20Supply%20Chain%20Analytics.xlsx) — interactive dashboard, calculations, and embedded queries.
- [Dashboard screenshot](Dashboard.png) — view without opening Excel.

**To reproduce:** Open the workbook in desktop Excel, open **Data → Queries & Connections**, and inspect the queries in Power Query Editor. The source URL in `raw_data` requires internet access. The standalone `.m` file documents the exact transformations used in the workbook. Delivery-level counting and executive visualizations are completed within Excel.

## Approach

- Cleaned the historical records in **Power Query**, standardizing fields and dates.
- Evaluated delivery timeliness **per unique ASN/DN reference**, preventing multi-product shipments from being counted as multiple deliveries.
- Classified deliveries as **on time** when the delivered-to-client date was on or before the scheduled date.
- Computed quantity-weighted pack prices using **sum of line item value / sum of line item quantity**, comparing prices **within the same ARV presentation** over time.
- Examined recorded commodity value by country and fulfillment channel, and evaluated channel concentration alongside delivery timeliness.
- Built an **interactive Excel dashboard** and **management report** to communicate findings and operational priorities.

## Management takeaways

The **From RDC** channel is the leading recorded delivery-reliability concern: it has lower on-time performance and accounts for most late deliveries. The findings motivate review of RDC scheduling, destination-country logistics challenges, and potential contingency arrangements. Recorded pack prices for several important ARV presentations fell over the period, but price declines alone do not prove cost competitiveness.

## Important limitations

- **Recorded commodity value is not necessarily procurement expenditure**, particularly for products fulfilled from an RDC.
- A weighted average across different medicines is not a valid price-reasonableness benchmark; equivalent product presentations must be compared.
- No external price benchmark or purchase-contract analysis was used, so **reasonable procurement cost cannot be conclusively established**.
- Shipping data cannot prove facility-level medicine availability, actual stockouts, or uninterrupted supply without demand and inventory records.
- This historical, descriptive assessment does not establish causation or supplier fault.

## Project deliverables

- **[Excel workbook](USAID%20Supply%20Chain%20Analytics.xlsx):** cleaned data, calculations, interactive dashboard, and management report.
- **[Dashboard screenshot](Dashboard.png):** visual preview.
- **[Original Power Query M code](power_query/Section1.m):** reproducible extraction and cleaning logic.

## Dashboard preview

![USAID ARV supply chain performance dashboard](Dashboard.png)

## Project context

Independent supply-chain analytics portfolio case study using publicly available historical data.
