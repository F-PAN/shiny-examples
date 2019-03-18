

library(leaflet)
library(ggvis)

# Choices for drop-downs
vars <- c(
  "Is SuperZIP?" = "superzip",
  "Centile score" = "centile",
  "College education" = "college",
  "Median income" = "income",
  "Population" = "adultpop"
)

fluidPage(
  titlePanel("Movie explorer"),

  fluidRow(
    column(8,
           div(class="innen",

               tags$head(
                 # Include our custom CSS
                 includeCSS("styles.css"),
                 includeScript("gomap.js")
               ),
               # If not using custom CSS, set height of leafletOutput to a number instead of percent
               leafletOutput("map", width="100%", height="850")
               # wellPanel(
               #   span("Number of movies selected:",
               #        textOutput("n_movies"),
               #        h2("ZIP explorer"),
               #        selectInput("states", "States", c("All states"="", structure(state.abb, names=state.name), "Washington, DC"="DC"), multiple=TRUE),
               #        conditionalPanel("input.states",
               #                         selectInput("cities", "Cities", c("All cities"=""), multiple=TRUE)
               #        ),
               #        conditionalPanel("input.states",
               #                         selectInput("zipcodes", "Zipcodes", c("All zipcodes"=""), multiple=TRUE)
               #        ),
               #        numericInput("minScore", "Min score", min=0, max=100, value=0)
               #
               #
               #
               #
               #   ),


               )
           ),
    column(4,
           wellPanel(
             h4("Filter"),
             selectInput("color", "Color", vars),
             selectInput("size", "Size", vars, selected = "adultpop"),
             conditionalPanel("input.color == 'superzip' || input.size == 'superzip'",
                              # Only prompt for threshold when coloring or sizing by superzip
                              numericInput("threshold", "SuperZIP threshold (top n percentile)", 5)


             ),
             wellPanel(
               plotOutput("histCentile", height = 250)
               #plotOutput("scatterCollegeIncome", height = 250)
             ),

             wellPanel(
               selectInput("states", "States", c("All states"="", structure(state.abb, names=state.name), "Washington, DC"="DC"), multiple=TRUE),
               conditionalPanel("input.states",
                                selectInput("cities", "Cities", c("All cities"=""), multiple=TRUE)
               ),
               conditionalPanel("input.states",
                                selectInput("zipcodes", "Zipcodes", c("All zipcodes"=""), multiple=TRUE)
               ),
               numericInput("minScore", "Min score", min=0, max=100, value=0),
               numericInput("maxScore", "Max score", min=0, max=100, value=100)
             )


             )
    )

  ),
  fluidRow(
           hr(),
           DT::dataTableOutput("ziptable")

  )

  )




