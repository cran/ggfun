## ----style, echo=FALSE, results="asis", message=FALSE-------------------------
knitr::opts_chunk$set(tidy = FALSE,
		   message = FALSE)

library("grid")
library("ggplot2")
library("ggfun")
theme_set(theme_grey())

## -----------------------------------------------------------------------------
library("grid")
library("ggplot2")
library("ggfun")

## -----------------------------------------------------------------------------
p <- ggplot(mtcars, aes(mpg, disp, color=factor(cyl), size=cyl)) + geom_point()

keybox(p, 'rect')

## -----------------------------------------------------------------------------
keybox(p, 'roundrect', gp = gpar(col = '#808080', lty = "dashed"))

## -----------------------------------------------------------------------------
p <- ggplot(mtcars, aes(mpg, disp)) + geom_point()
data <- data.frame(colour = c("red",  "blue"), VALUE = c("A", "B"))
gglegend(aes(colour = VALUE, label=VALUE), data, geom_text, p)

## -----------------------------------------------------------------------------
d <- data.frame(x=rnorm(10), y=rnorm(10), lab=LETTERS[1:10])
p <- ggplot(d, aes(x, y)) + geom_text(aes(label=lab), size=5)
set_font(p, family="Times", fontface="italic", color='firebrick')

