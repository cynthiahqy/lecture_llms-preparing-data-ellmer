# --- add-system-prompt ---

session_tidy_expert <- chat_openai(system_prompt = "
  You are an expert R programmer
  who prefers the tidyverse.
  Only return code without explanation.
")

session_tidy_expert$chat(question)

session_tidy_expert