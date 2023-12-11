##### Southeast-Asia dataset prep #####

# clear environment and set working directory
rm(list = ls())
setwd("/Users/dennispruss/Documents/02_Karriere/01_pruess_xyz/01_Projects/003_Südostasien_dashboard")

# import dataset  
seasia_data <- read.csv("IMFCrossCountryMacroeconomicStatistics.csv", header = TRUE, sep = ",", dec = ".")

# display the first few rows of the data
head(seasia_data)

# list of southeast asian country codes
country_codes <- c("BRN", "KHM", "IDN", "LAO", "MYS", "MMR", "PHL", "SGP", "THA", "TLS", "VNM")

# filter the data for southeast asian countries
seasia_data <- seasia_data[substr(seasia_data$indicator, 1, 3) %in% country_codes, ]

# display the filtered data
head(seasia_data)

# separate the indicator column into two columns
seasia_data$country_code <- substr(seasia_data$indicator, 1, 3)
seasia_data$indicator_code <- substr(seasia_data$indicator, 5, nchar(seasia_data$indicator))

# drop the original indicator column
seasia_data <- seasia_data[, -1]

# display the modified data
head(seasia_data)

# create a mapping of indicator codes to names
# this function was generated with ChatGPT
indicator_mapping <- data.frame(
  indicator_code = c("PPPGDP", "BCA_NGDPD", "BCA", "LE", "TX_RPCH", "TXG_RPCH", "NGDP_FY", "NGDP_D", "NGDP_RPCH", "NGDP_R",
                     "NGDP", "NGDPD", "NGDPRPC", "NGDPPC", "NGDPDPC", "GGXWDG_NGDP", "GGXWDG", "GGXWDN_NGDP", "GGXWDN", 
                     "GGXCNL_NGDP", "GGXCNL", "GGXONLB_NGDP", "GGXONLB", "GGR_NGDP", "GGR", "GGSB_NPGDP", "GGSB", "GGX_NGDP",
                     "GGX", "NGSD_NGDP", "PPPEX", "TM_RPCH", "TMG_RPCH", "PCPIPCH", "PCPIEPCH", "PCPI", "PCPIE", "NGAP_NPGDP",
                     "PPPPC", "LP", "PPPSH", "NID_NGDP", "LUR"),
  indicator_name = c("Country GDP based on PPP Valuation, USD Billions", "Current Account Balance, % of GDP", 
                     "Current Account Balance, USD Billions", "Employment, Millions", "Exports of Goods and services, % change",
                     "Exports of Goods, % change", "GDP Corresponding to Fiscal Year, Current Prices, LCU Billions", 
                     "GDP Deflator", "GDP at Constant Prices, % change", "GDP at Constant Prices, LCU Billions", 
                     "GDP at Current Prices, LCU Billions", "GDP at Current Prices, USD Billions", "GDP per Capita at Constant Prices, LCU",
                     "GDP per Capita at Current Prices, LCU", "GDP per Capita at Current Prices, USD", 
                     "General Government Gross Debt, % of GDP", "General Government Gross Debt, USD Billions", 
                     "General Government Net Debt, % of GDP", "General Government Net Debt, USD Billions", 
                     "General Government Net Lending/Borrowing, % of GDP", "General Government Net Lending/Borrowing, USD Billions", 
                     "General Government Primary Net Lending/Borrowing, % of GDP Billions", "General Government Primary Net Lending/Borrowing, USD Billions",
                     "General Government Revenue, % of GDP", "General Government Revenue, USD Billions", 
                     "General Government Structural Balance, % of GDP", "General Government Structural Balance, USD Billions", 
                     "General Government Total Expenditure, % of GDP", "General Government Total Expenditure, USD Billions", 
                     "Gross National Savings, % of GDP", "Implied PPP Conversion Rate, LCU per USD", 
                     "Imports of Goods and services, % change", "Imports of Goods, % change", "Inflation % change, Average Consumer Prices", 
                     "Inflation % change, End of Period Consumer Prices", "Inflation Index, Average Consumer Prices", 
                     "Inflation Index, End of Period Consumer Prices", "Output Gap, % of potential GDP", 
                     "Per Capita GDP based on PPP Valuation, USD", "Population, Millions", 
                     "Share of World GDP based on PPP, %", "Total Investment, % of GDP", "Unemployment Rate, % of Total Labor Force"))

# merge the data frames to add the indicator name column
seasia_data <- merge(seasia_data, indicator_mapping, by.x = "indicator_code", by.y = "indicator_code", all.x = TRUE)

# display the modified data
head(seasia_data)

# remove rows with missing values
seasia_data <- na.omit(seasia_data)

# display the modified data
head(seasia_data)

# list of countries and their codes
country_list <- data.frame(
  code = c("BRN", "KHM", "IDN", "LAO", "MYS", "MMR", "PHL", "SGP", "THA", "TLS", "VNM"),
  country_name = c("Brunei Darussalam", "Cambodia", "Indonesia", "Lao PDR", "Malaysia", "Myanmar", "Philippines", "Singapore", "Thailand", "Timor-Leste", "Vietnam"))

# merge the data frames to add the country name column
seasia_data <- merge(seasia_data, country_list, by.x = "country_code", by.y = "code", all.x = TRUE)

# display the modified data
head(seasia_data)

# remove rows with missing values
seasia_data <- na.omit(seasia_data)

# display the modified data
head(seasia_data)

# specify the path and filename for the CSV file
csv_path <- "/Users/dennispruss/Documents/02_Karriere/01_pruess_xyz/01_Projects/003_Südostasien_dashboard/Southeast_Asia_Macro_Dashboard.csv"

# write the data frame to a CSV file
write.csv(seasia_data, file = csv_path, row.names = FALSE)
