library(ellmer)

session <- chat_openai()

prompt <- "Write a yaml dataset of the instructors of Monash University's wild caught data course"

# -- "just" like front-end
# -- no tools!

session$chat(prompt)

session

session$chat("csv please")

session

# ---- system prompt

question <- "
  How can I compute the mean of
   variables a, b, c, and so on,
   all the way up to z.
"

## -- new session --
session <- chat_openai()
session


session$chat(question)

session_tidy_expert <- chat_openai(system_prompt = "
  You are an expert R programmer
  who prefers the tidyverse.
")

session_tidy_expert$chat(question)

# --- 

library(tidyverse)

author_df <- readr::read_csv('example_data/week10-author_df.csv')

session_lib <- chat_openai(system_prompt = "You are a librarian with expert knowledge of popular authors.")

nationality_prompt <- "Nationality of person"

session_lib$extract_data("Kate Saunders",
                               type = type_string(description = nationality_prompt))

session_lib <- chat_openai(system_prompt = "You are a librarian with expert knowledge of popular authors.")

better_prompt <- "Nationality of person only"

session_lib$extract_data("Kate Saunders",
                               type = type_string(description = better_prompt))

even_better_prompt <- "Nationality of person in 3-digit ISO country code standard"

session_lib$extract_data("Kate Saunders",
                               type = type_string(description = even_better_prompt))

## -- stereotyping! unless you're famous

author_df |>
  head(6) |>
  rowwise() |>
  mutate(nationality_librarian = 
           session_librarian$clone()$extract_data(author_name,
                                                  type = type_string(better_prompt))
    )
