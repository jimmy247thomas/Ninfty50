# server.R
server <- function(input, output) {

  stock_data <- eventReactive(input$fetch_data, {
    print("Fetching stock data...")
    tryCatch({
      getSymbols(input$stock, from = input$start_date, to = input$end_date, auto.assign = FALSE)
    }, error = function(e) {
      showNotification(paste("Error fetching data:", e$message), type = "error")
      return(NULL)
    })
  })

  nifty_data <- eventReactive(input$fetch_data, {
    print("Fetching Nifty data...")
    tryCatch({
      getSymbols("^NSEI", from = input$start_date, to = input$end_date, auto.assign = FALSE)
    }, error = function(e) {
      showNotification(paste("Error fetching Nifty data:", e$message), type = "error")
      return(NULL)
    })
  })

  output$stock_plot <- renderPlot({
    print("Rendering stock plot...")
    data <- stock_data()
    if (!is.null(data)) {
      chartSeries(data, name = input$stock)
    }
  })

  output$stock_table <- renderDT({
    print("Rendering stock table...")
    data <- stock_data()
    if (!is.null(data)) {
      df <- as.data.frame(data)
      numeric_cols <- sapply(df, is.numeric)
      df[numeric_cols] <- round(df[numeric_cols], 3)
      datatable(df)
    }
  })

  output$stock_nifty_price_plot <- renderPlot({
    print("Rendering Stock vs Nifty price plot...")
    stock <- stock_data()
    nifty <- nifty_data()
    if (!is.null(stock) && !is.null(nifty)) {
      stock_close <- Cl(stock)
      nifty_close <- Cl(nifty)

      df <- data.frame(Date = index(stock_close),
                       Stock = as.numeric(stock_close),
                       Nifty = as.numeric(nifty_close))

      ggplot(df, aes(x = Date)) +
        geom_line(aes(y = Nifty, color = "Nifty 50")) +
        geom_line(aes(y = Stock, color = input$stock)) +
        scale_y_continuous(
          name = "Nifty 50 Price",
          sec.axis = sec_axis(~., name = paste(input$stock, "Price"))
        ) +
        labs(title = "Stock vs. Nifty 50 Price",
             x = "Date",
             color = "Legend") +
        theme_minimal() +
        theme(axis.title.y.right = element_text(color = "blue"),
              axis.text.y.right = element_text(color = "blue"))

    }
  })
}
