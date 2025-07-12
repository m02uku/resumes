// --- Imports ---
#import "@preview/touying:0.6.1": *
#import themes.university: *
#import "@preview/numbly:0.1.0": numbly
#import "@preview/cetz:0.4.0"
#import cetz.draw: *
#import "@preview/fletcher:0.5.8" as fletcher: *
#import fletcher.shapes: *
#import "@preview/lovelace:0.3.0": *
#import "@preview/algorithmic:1.0.0"
#import algorithmic: *
#import "@preview/codelst:2.0.2": sourcecode
#import "@preview/showybox:2.0.4": *
#import "@preview/tablem:0.2.0": *
#import "@preview/pinit:0.2.2": *
#import "@preview/gentle-clues:1.2.0": *
#import "@preview/lilaq:0.3.0" as lq
#import "@preview/acrostiche:0.5.2": *
#import "@preview/ascii-ipa:2.0.0": *
#import "@preview/eggs:0.1.0": *
#import "@preview/cjk-unbreak:0.1.1": remove-cjk-break-space


// --- Theme Settings ---
#show: university-theme.with(aspect-ratio: "16-9", config-info(
  title: [title],
  subtitle: [subtitle],
  author: [Sora Nagano (\@m02uku)],
  date: datetime.today(),
  institution: [The University of Tokyo],
))


// --- Style and Layout ---
#show table.cell.where(y: 0): strong
#set text(font: ("Noto Serif", "Noto Serif CJK JP"), size: 25pt)
#set heading(numbering: numbly("{1}.", default: "1.1"))
#show heading.where(level: 3): it => [
  #block(it.body)
]
#show: remove-cjk-break-space


// --- Functions ---
#let citet(..citation) = {
  cite(..citation, form: "prose")
}


// --- Content ---

// Title & Outline

#title-slide()

== Outline <touying:hidden>

#components.adaptive-columns(outline(title: none, indent: 1em))

// Main Content

= Introduction

== What is Embeddings?

- Embeddings is one of the most important techniques in NLP @YongYe2025LuErDaoFangYanFuHeMingCiakusentonoXinJiuBiJiao.

// Bibliography

#pagebreak()

#text(size: 12pt)[
  #bibliography(
    "../../../static/references.bib",
    style: "apa",
    title: "References",
  )
]
