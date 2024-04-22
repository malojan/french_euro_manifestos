
needs(tidyverse, tidytext)

euro_2019 <- fs::dir_ls("raw_data/txt/2019") |> 
  # Import txt file by having all the text in the same column named text and add file name
  map_dfr(~ read_delim(.x, delim = "\t", col_names = FALSE, col_types = "c", id = "file")) |> 
  rename(text = X1) |> 
  mutate(
         election = 'EURO',
         year = 2019,
         party = str_extract(file, "(?<=PF_).*(?=_)")) |> 
  group_by(party) |> 
  mutate(text = paste0(text, collapse = " ")) |> 
  unique() |> 
  unnest_tokens(sentence, text, token = "sentences", to_lower = F)


# Save 

write_csv(euro_2019, "data/euro2019_profession_foi.csv")


pr_2022 <- fs::dir_ls("raw_data/txt/2022") |> 
  # Import txt file by having all the text in the same column named text and add file name
  map_dfr(~ read_delim(.x, delim = "\t", col_names = FALSE, col_types = "c", id = "file")) |> 
  rename(text = X1) |> 
  mutate(
    election = 'PR',
    year = 2022,
    party = str_extract(file, "(?<=PF_).*(?=_)")) |> 
  group_by(party) |> 
  mutate(text = paste0(text, collapse = " ")) |> 
  unique() |> 
  unnest_tokens(sentence, text, token = "sentences", to_lower = F)

pr_2012 |> view()
