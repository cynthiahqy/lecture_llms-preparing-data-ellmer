# ---- sessions-are-chat ---

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