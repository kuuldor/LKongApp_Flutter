final Map<String, String> themeColorKeys = {
  "main": "主色调",
  "barText": "标题栏文字颜色",
  "paper": "背景色",
  "headerBG": "标题背景",
  "quoteBG": "引文背景",
  "text": "正文颜色",
  "lightText": "淡色文字",
  "mediumText": "浅色文字",
  "darkText": "深色文字",
  "link": "链接颜色",
  "linkTap": "点击高亮"
};

final defaultTheme = {
  "name": "默认",
  "colors": {
    "main": "#0080C0",
    "paper": "#FFF",
    "headerBG": "#F0F0F0",
    "quoteBG": "#E9E9E9",
    "text": "#111",
    "lightText": "#999",
    "mediumText": "#666",
    "darkText": "#333",
    "barText": "#FFF",
    "link": "#0099CC",
    "linkTap": "rgba(51, 51, 51, 0.5)"
  }
};

final nightTheme = {
  "name": "默认夜间",
  "colors": {
    "main": "#222",
    "paper": "#111",
    "headerBG": "#282828",
    "quoteBG": "#333",
    "text": "#EEE",
    "lightText": "#666",
    "mediumText": "#999",
    "darkText": "#CCC",
    "barText": "#FFF",
    "link": "#0099CC",
    "linkTap": "rgba(204, 204, 204, 0.5)"
  }
};

final cssStyle = {
  "a": {
    "activeColor": "linkTap",
    "color": "link",
  },
  "body": {
    "margin": 0,
    "padding": 0,
    "font-family": "Avenir Next",
    "font-size": 1.0,
    "color": "text",
    "background-color": "paper",
  },
  ".darkText": {
    "color": "darkText",
  },
  ".mediumText": {
    "color": "mediumText",
  },
  ".lightText": {
    "color": "lightText",
  },
  ".metrobg": {
    "background-color": "headerBG",
    "border-top-color": "headerBG",
    "border-top-style": "solid",
    "border-top-width": 1,
  },
  ".smallfont": {
    "font-size": 0.5,
  },
  ".middlefont": {
    "font-size": 0.75,
  },
  ".pstatus": {
    "font-size": 0.75,
    "color": "lightText",
  },
  "blockquote": {
    "color": "mediumText",
  },
  ".rating": {
    "padding-top": 10,
    "padding-bottom": 10,
    "margin": "0 5 0 5",
    "overflow": "hidden",
    "word-wrap": "break-word",
    "img-width": 32,
  },
  ".ratingcontent": {
    "color": "darkText",
    "margin-left": 40,
  },
};
