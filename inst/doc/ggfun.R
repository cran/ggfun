## -----------------------------------------------------------------------------
#| label: setup
#| include: false
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.width = 6,
  fig.height = 4,
  message = FALSE,
  warning = FALSE
)

library(grid)
library(ggplot2)
library(ggfun)

source_root <- normalizePath(file.path(".."), winslash = "/", mustWork = FALSE)
if (file.exists(file.path(source_root, "DESCRIPTION")) &&
    requireNamespace("pkgload", quietly = TRUE)) {
  pkgload::load_all(source_root, quiet = TRUE)
}

theme_set(theme_bw())


## -----------------------------------------------------------------------------
#| label: rounded-strip
p <- ggplot(mpg, aes(displ, cty)) +
  geom_point(alpha = 0.7) +
  facet_grid(cols = vars(cyl))

p + theme(
  strip.background = element_roundrect(
    fill = "grey35",
    color = NA,
    r = 0.15
  ),
  strip.text = element_text(color = "white")
)


## -----------------------------------------------------------------------------
#| label: rounded-legend
ggplot(mtcars, aes(mpg, disp, color = factor(cyl), size = wt)) +
  geom_point(alpha = 0.8) +
  theme(
    legend.background = element_roundrect(
      fill = "grey97",
      color = "grey55",
      linetype = 2,
      r = 0.08
    )
  )


## -----------------------------------------------------------------------------
#| label: theme-blinds
df_blinds <- data.frame(
  group = rep(LETTERS[1:6], each = 3),
  sample = rep(c("A", "B", "C"), 6),
  value = c(2, 4, 3, 5, 3, 4, 4, 6, 5, 6, 5, 7, 3, 4, 6, 5, 7, 6)
)

ggplot(df_blinds, aes(sample, group)) +
  geom_point(aes(size = value, color = value)) +
  scale_color_viridis_c() +
  theme_blinds(axis = "y", colour = c("grey95", "white")) +
  theme(panel.grid.major.x = element_blank())


## -----------------------------------------------------------------------------
#| label: theme-helpers
ggplot(mtcars, aes(mpg, disp)) +
  geom_point(aes(color = factor(cyl)), size = 2) +
  theme_noxaxis()


## -----------------------------------------------------------------------------
#| label: theme-transparent
ggplot(mtcars, aes(mpg, disp)) +
  geom_point(aes(color = factor(cyl)), size = 2) +
  theme_transparent()


## -----------------------------------------------------------------------------
#| label: geom-hist
set.seed(42)
df_hist <- data.frame(
  value = c(rnorm(120), rnorm(120, mean = 2)),
  group = rep(c("A", "B"), each = 120)
)

ggplot(df_hist, aes(value, fill = group)) +
  geom_hist(breaks = 16, position = "identity", alpha = 0.55, color = "white")


## -----------------------------------------------------------------------------
#| label: geom-xspline
set.seed(123)
df_line <- data.frame(
  x = rep(1:10, 2),
  y = c(cumsum(rnorm(10)), cumsum(rnorm(10, sd = 0.7)) + 2),
  series = rep(c("A", "B"), each = 10)
)

ggplot(df_line, aes(x, y, color = series, group = series)) +
  geom_point(size = 2) +
  geom_xspline(linewidth = 1, shape = 1)


## -----------------------------------------------------------------------------
#| label: geom-segment-c
df_segments <- data.frame(
  x = c(0, 1, 2, 3),
  xend = c(1, 2, 3, 3),
  y = c(0, 1, 0.5, 0),
  yend = c(1, 0.5, 1.5, 1.5),
  start = c(0.1, 0.3, 0.5, 0.7),
  end = c(0.4, 0.6, 0.9, 1.0)
)

ggplot(df_segments) +
  geom_segment_c(
    aes(x = x, y = y, xend = xend, yend = yend, col0 = start, col1 = end),
    linewidth = 2,
    lineend = "round"
  ) +
  scale_color_viridis_c(name = "value") +
  coord_equal()


## -----------------------------------------------------------------------------
#| label: geom-scatter-rect
df_rect <- data.frame(
  x = rep(1:5, 2),
  y = rep(1:2, each = 5),
  value = c(1, 3, 2, 4, 5, 2, 4, 3, 5, 6)
)

ggplot(df_rect, aes(x, y)) +
  geom_scatter_rect(aes(fill = value), width = 0.85, height = 0.5, color = "white") +
  scale_y_continuous(breaks = 1:2, labels = c("control", "treated")) +
  scale_fill_viridis_c()


## -----------------------------------------------------------------------------
#| label: geom-custom-glyphs
df_glyph <- data.frame(
  x = 1:4,
  y = c(1, 2, 1.4, 2.4),
  angle = c(0, 45, 90, 135),
  cake_size = c(0.18, 0.2, 0.16, 0.22)
)

ggplot(df_glyph, aes(x, y)) +
  geom_triangle(aes(angle = angle), fill = "tomato", size = 16, alpha = 0.8) +
  geom_cake(aes(y = y + 0.45, size = cake_size), colour.cake = "pink") +
  coord_equal(xlim = c(0.5, 4.5), ylim = c(0.5, 3.2)) +
  theme_noaxis()


## -----------------------------------------------------------------------------
#| label: facet-set-labels
p_facet <- ggplot(mtcars, aes(disp, drat)) +
  geom_point() +
  facet_grid(cols = vars(am), rows = vars(cyl))

p_facet + facet_set(label = c(`0` = "Automatic", `1` = "Manual", `6` = "Six cylinders"))


## -----------------------------------------------------------------------------
#| label: facet-set-single
ggplot(mtcars, aes(mpg, disp)) +
  geom_point() +
  facet_set("Motor Trend cars")


## -----------------------------------------------------------------------------
#| label: plot-data
p_data <- ggplot(mtcars, aes(mpg, disp, color = factor(cyl))) +
  geom_point()

get_aes_var(p_data$mapping, "x")
head(get_plot_data(p_data, var = c("x", "y")))


## -----------------------------------------------------------------------------
#| label: plot-range
xrange(p_data)
yrange(p_data)
ggrange(p_data, var = "x", region = "plot", type = "range")


## -----------------------------------------------------------------------------
#| label: get-legend
p_legend <- ggplot(mtcars, aes(mpg, disp, color = factor(cyl))) +
  geom_point(size = 2)

legend <- get_legend(p_legend)
class(legend)


## -----------------------------------------------------------------------------
#| label: gglegend
p_base <- ggplot(mtcars, aes(mpg, disp)) +
  geom_point()

legend_data <- data.frame(
  colour = c("firebrick", "steelblue"),
  label = c("Group A", "Group B")
)

gglegend(aes(colour = label, label = label), legend_data, geom_text, p_base)


## -----------------------------------------------------------------------------
#| label: set-font
df_text <- data.frame(
  x = 1:5,
  y = c(2, 3, 2.5, 4, 3.5),
  label = LETTERS[1:5]
)

p_text <- ggplot(df_text, aes(x, y, label = label)) +
  geom_text(size = 5) +
  labs(title = "Edited text grobs")

set_font(p_text, family = "serif", fontface = "italic", color = "firebrick")

