make_barplot <- function(data){
  ggplot(data) +
  aes(x = language, y = relative_perc, fill = language) +
  geom_col() +
  scale_y_continuous(breaks = seq(0, 1, 0.2), limits = c(0, 1), expand = c(0, 0), labels = c(0, 0.2, 0.4, 0.6, 0.8, 1)) +
  theme_classic() +
  theme(
      axis.title = element_blank(),
      axis.text = element_text(size = 20, face = "bold"),
      axis.ticks.length.x = unit(2, "mm"),
      axis.line.y = element_blank(),
      axis.ticks.y = element_blank()
  ) +
  coord_flip()  +
  scale_fill_manual(values = c(
                    "Abap" =	"#06A9EA",
                    "Ada" =	"#101EC8",
                    "C/C++"	= "#00599C",
                    "C#" = "#813084",
                    "Cobol" =	"#1D1063",
                    "Dart" =	"#2DB6F6",
                    "Delphi" =	"#F32835",
                    "Go" =	"#66D0DE",
                    "Groovy" =	"#619CBC",
                    "Haskell" =	"#8F4E8B",
                    "Java" =	"#F8981E",
                    "JavaScript" =	"#F3D23C",
                    "Julia" =	"#369325",
                    "Kotlin" =	"#7F52FF",
                    "Lua" =	"#0F007C",
                    "Matlab" =	"#F0800E",
                    "Objective-C" =	"#AFB6CA",
                    "Perl" =	"#113E62",
                    "PHP" =	"#7277AD",
                    "Python" =	"#336994",
                    "R" =	"#2566B5",
                    "Ruby" =	"#B01E00",
                    "Rust" =	"#000000",
                    "Scala" =	"#DE3424",
                    "Swift" =	"#E94F37",
                    "TypeScript" =	"#3178C6",
                    "VBA" =	"#93217F",
                    "Visual Basic" = "#506AA0"
                    ), guide = FALSE)
}

make_lineplot <- function(data){
ggplot(data) +
  geom_line(aes(x = year, y = log(mean_yearly_pop), group = language, color = language), size = 1.5) +
    #scale_y_continuous(breaks = seq(0, 0.4, 0.1), expand = c(0, 0.02), limits = c(0, 0.4)) +
    scale_x_continuous(breaks = seq(2004, 2020, 2), expand = c(0.1, 0)) +
    theme_classic() +
    theme(
      axis.title = element_blank(),
      axis.text = element_text(size = 20, face = "bold"),
      axis.ticks.length.x = unit(2, "mm"),
      axis.line.y = element_blank(),
      axis.ticks.y = element_blank(),
      axis.text.y = element_blank()
    ) +
    scale_color_manual(values = c(
      "Abap" =	"#06A9EA",
      "Ada" =	"#101EC8",
      "C/C++"	= "#00599C",
      "C#" = "#813084",
      "Cobol" =	"#1D1063",
      "Dart" =	"#2DB6F6",
      "Delphi" =	"#F32835",
      "Go" =	"#66D0DE",
      "Groovy" =	"#619CBC",
      "Haskell" =	"#8F4E8B",
      "Java" =	"#F8981E",
      "JavaScript" =	"#F3D23C",
      "Julia" =	"#369325",
      "Kotlin" =	"#7F52FF",
      "Lua" =	"#0F007C",
      "Matlab" =	"#F0800E",
      "Objective-C" =	"#AFB6CA",
      "Perl" =	"#113E62",
      "PHP" =	"#7277AD",
      "Python" =	"#336994",
      "R" =	"#2566B5",
      "Ruby" =	"#B01E00",
      "Rust" =	"#000000",
      "Scala" =	"#DE3424",
      "Swift" =	"#E94F37",
      "TypeScript" =	"#3178C6",
      "VBA" =	"#93217F",
      "Visual Basic" = "#506AA0"
    ), guide = FALSE) + 
    geom_label(data = subset(data, year == "2020"),
             aes(label = language, y = log(mean_yearly_pop), x = 2020),
             size = 7,
             fill = "#D9534F",
             colour = "white",
             label.size = 0)

}
