## TODO: check what are NA values in the data

## TODO: run again using Claude

library(dplyr)

author_df <- readr::read_csv('example_data/week10-author_df.csv')

short_prompt <- "Nationality of person only"

session_lib <- chat_openai(system_prompt = "You are a librarian with expert knowledge of popular authors.")

author_df_llm <- author_df |>
  rowwise() |>
  mutate(nationality_llm = 
          session_lib$clone()$extract_data(author_name,
                                                  type = type_string(short_prompt))
    )

## -- saved on 2025-05-18 from gpt-4o response --

# author_df_llm |>
#   readr::write_csv('example_data/week11-author_df_llm.csv')

# author_df_llm |>
#   dplyr::mutate(nationality = na_if(nationality, "No nationality matched")) |>
#   readr::write_csv('example_data/week11-author_df_llm_na-if.csv')