source("dependencies.R")
# ui.R
ui <- dashboardPage(
  dashboardHeader(title = "Nifty 50 Stock Analysis"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Stock Plot", tabName = "stock_plot_tab", icon = icon("chart-line")),
      menuItem("Stock Data", tabName = "stock_data_tab", icon = icon("table")),
      menuItem("Stock vs Nifty", tabName = "stock_vs_nifty_tab", icon = icon("line-chart"))
    ),
    selectInput("stock", "Select Stock (Nifty 50):",
                choices = c("RELIANCE.NS", "TCS.NS", "HDFCBANK.NS", "INFY.NS", "ICICIBANK.NS",
                            "HINDUNILVR.NS", "SBIN.NS", "BAJFINANCE.NS", "KOTAKBANK.NS", "BHARTIARTL.NS",
                            "LT.NS", "AXISBANK.NS", "ASIANPAINT.NS", "M&M.NS", "TITAN.NS",
                            "HCLTECH.NS", "ULTRACEMCO.NS", "WIPRO.NS", "ADANIPORTS.NS", "JSWSTEEL.NS",
                            "NTPC.NS", "POWERGRID.NS", "GRASIM.NS", "BAJAJFINSV.NS", "NESTLEIND.NS",
                            "HDFC.NS", "TATAMOTORS.NS", "COALINDIA.NS", "ONGC.NS", "DIVISLAB.NS",
                            "TECHM.NS", "ADANIENT.NS", "CIPLA.NS", "SUNPHARMA.NS", "BAJAJAUTO.NS",
                            "LTIM.NS", "SHREECEM.NS", "MARUTI.NS", "APOLLOHOSP.NS", "HEROMOTOCO.NS",
                            "EICHERMOT.NS", "DMART.NS", "SBILIFE.NS", "TATACONSUM.NS", "HINDALCO.NS",
                            "UPL.NS", "BPCL.NS", "INDUSINDBK.NS", "IOC.NS", "DRREDDY.NS")),
    dateInput("start_date", "Start Date:", value = Sys.Date() - 365),
    dateInput("end_date", "End Date:", value = Sys.Date()),
    actionButton("fetch_data", "Fetch Data")
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "stock_plot_tab",
              fluidRow(
                box(plotOutput("stock_plot"), width = 12)
              )
      ),
      tabItem(tabName = "stock_data_tab",
              fluidRow(
                box(DTOutput("stock_table"), width = 12)
              )
      ),
      tabItem(tabName = "stock_vs_nifty_tab",
              fluidRow(
                box(plotOutput("stock_nifty_price_plot"), width = 12)
              )
      )
    )
  )
)
