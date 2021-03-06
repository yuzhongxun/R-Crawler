# 認識 JSON 與 XML
# 遇到JSON 與 XML的檔案, 使用jsonlite 與 xml2套件
install.packages("jsonlite")
library(jsonlite)

# 驗證為字串
friends <-  '{
  "genre": "Sitcom",
  "seasons": 10,
  "episodes": 236,
  "stars": ["Jennifer Aniston", "Courteney Cox", "Lisa Kudrow", "Matt LeBlanc", "Matthew Perry", "David Schwimmer"]
}'

class(friends)

# fromJSON()
friends_list <- fromJSON(friends)
friends_list
paste("六人行共有幾季：", friends_list$seasons)
paste("六人行共有幾集：", friends_list$episodes)
paste("誰飾演 Chandler Bing：", friends_list$stars[5])


# 練習1
# 芝加哥公牛隊 1995-96 年球季的勝率（勝場數/總場數）為？ (hint: 使用sprintf函數)
# 從先發五人選出你最喜歡的球員
best_chicago_bulls <- '{
    "season": "1995-96",
    "wins": 72,
    "losses": 10,
    "head_coach": "Phil Jackson",
    "starting_five": ["Scottie Pippen", "Dennis Rodman", "Luc Longley", "Ron Harper", "Michael Jordan"]
}'
cb_list <- fromJSON(best_chicago_bulls)       # 使用 fromJSON回傳到list, 再呼叫出來 
cb_list
sprintf("勝率是: %f", cb_list$wins / (cb_list$wins + cb_list$losses))
sprintf("我最喜歡的先發球員: %s", cb_list$starting_five[5])

# 用for迴圈跑JSON在matrix的結果
friends_starring <- '[
  {
    "character": "Rachel Green",
    "star": "Jennifer Aniston"
  },
  {
    "character": "Monica Geller",
    "star": "Courteney Cox"
  },
  {
    "character": "Phoebe Buffay",
    "star": "Lisa Kudrow"
  },
  {
    "character": "Joey Tribbiani",
    "star": "Matt LeBlanc"
  },
  {
    "character": "Chandler Bing",
    "star": "Matthew Perry"
  },
  {
    "character": "Ross Geller",
    "star": "David Schwimmer"
  }]'

starrings_df <- fromJSON(friends_starring)
View(starrings_df)         # JSON會自動轉換為matrix, 用View查看table

for (i  in 1:nrow(starrings_df)) {
  print(sprintf("誰飾演 %s: %s", starrings_df[i, "character"],
                starrings_df[i, "star"]))
}


# 練習2
# 列出芝加哥公牛隊 1995-96 年先發五人的位置與球員
best_cb_start_five <- '[
{
  "pos": "SF",
  "player": "Scottie Pippen"
},
{
  "pos": "PF",
  "player": "Dennis Rodman"
},
{
  "pos": "C",
  "player": "Luc Longley"
},
{
  "pos": "PG",
  "player": "Ron Harper"
},
{
  "pos": "SG",
  "player": "Michael Jordan"
}
]'

cb_df <- fromJSON(best_cb_start_five)
View(cb_df)
for (i in 1:nrow(cb_df)) {
  print(sprintf("位置: %s, 球員: %s", cb_df[i, "pos"],
                cb_df[i, "player"]))
}


# read_xml()
install.packages("xml2")
library(xml2)

fs_xml <- "
<Friends>
<cast>
<character>Rachel Green</character>
<star>Jennifer Aniston</star>
</cast>
<character>Monica Geller</character>
<star>Courteney Cox</star>
<cast>
<character>Phoebe Buffay</character>
<star>Lisa Kudrow</star>
</cast>
<cast>
<character>Joey Tribbiani</character>
<star>Matt LeBlanc</star>
</cast>
<cast>
<character>Chandler Bing</character>
<star>Matthew Perry</star>
</cast>
<cast>
<character>Ross Geller</character>
<star>David Schwimmer</star>
</cast>
</Friends>
"

fs <- read_xml(fs_xml)
class(fs)
mode(fs)    # 是一個 list

fs_name <- xml_name(fs)
fs_name

xml_children(fs)
fs_characters <- xml_find_all(fs, xpath = ".//character")
fs_characters
xml_text(fs_characters)
xml_text(fs_characters)[5]

fs_stars <- xml_find_all(fs, xpath = ".//star")
fs_stars

