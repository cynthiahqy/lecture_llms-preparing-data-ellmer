library(ellmer)

# ---- session-are-chat ---

## A session is like a chat conversation
session <- chat_openai()

question <- "
  How can I pick a random letter from A-Z.
"

## send a question to the 'chat'
session$chat(question)

## clarify your request
session$chat("Return R code only")

## inspect all turns in the session so far
session

# --- add-system-prompt ---

session_tidy_expert <- chat_openai(system_prompt = "
  You are an expert R programmer
  who prefers the tidyverse.
  Only return code without explanation.
")

session_tidy_expert$chat(question)

session_tidy_expert

## ---- jane-austen-extract-from-text ----

text <- "Jane Austen (/ˈɒstɪn, ˈɔːstɪn/ OST-in, AW-stin; 16 December 1775 – 18 July 1817) was an English novelist known primarily for her six novels, which implicitly interpret, critique, and comment on the English landed gentry at the end of the 18th century. Austen's plots often explore the dependence of women on marriage for the pursuit of favourable social standing and economic security. Her works are implicit critiques of the novels of sensibility of the second half of the 18th century and are part of the transition to 19th-century literary realism.[2][b] Her use of social commentary, realism, wit, and irony have earned her acclaim amongst critics and scholars.\n"

session_read <- chat_openai(system_prompt = "You are a data entry assistant.")

session_read <- chat_openai()

nationality_prompt <- "Nationality of person"

session_read$extract_data(text, type = type_string(description = nationality_prompt))

std_prompt <- "Extract structured data of the nationality of person. Return only ISO 3-digit country code (e.g. GBR, USA)"

session_read$extract_data(text, type = type_string(description = std_prompt))

## ---- missing-data-guess-scale-up ----

library(dplyr)

author_df <- readr::read_csv('example_data/week10-author_df.csv')

short_prompt <- "Nationality of person only"

session_lib <- chat_openai(system_prompt = "You are a librarian with expert knowledge of popular authors.")

author_df |>
  tail(6) |>
  rowwise() |>
  mutate(nationality_librarian = 
          session_lib$clone()$extract_data(author_name,
                                                  type = type_string(short_prompt))
    )

## --- age-guess ---

session$chat("How old is Kate Saunders? Return only the age.")
