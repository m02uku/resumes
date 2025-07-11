#import "@preview/jaconf:0.5.0": appendix, corollary, definition, jaconf, lemma, proof, theorem

// デフォルト値でよい引数は省略可能
#show: jaconf.with(
  // 基本 Basic
  title: [日本語のタイトル],
  title-en: [English Title],
  authors: [永野 颯],
  authors-en: [Sora NAGANO],
  abstract: [#lorem(80)],
  keywords: ([Typst], [conference paper writing], [manuscript format]),
  // フォント名 Font family
  font-heading: "Noto Sans CJK JP", // サンセリフ体、ゴシック体などの指定を推奨
  font-main: "Noto Serif CJK JP", // セリフ体、明朝体などの指定を推奨
  font-latin: "New Computer Modern",
  font-math: "New Computer Modern Math",
  // 外観 Appearance
  paper-margin: (top: 20mm, bottom: 27mm, left: 20mm, right: 20mm),
  paper-columns: 2, // 1: single column, 2: double column
  page-number: none, // e.g. "1/1"
  column-gutter: 4% + 0pt,
  spacing-heading: 1.2em,
  bibliography-style: "apa", // "sice.csl", "rsj.csl", "ieee", etc.
  abstract-language: "en", // "ja" or "en"
  keywords-language: "en", // "ja" or "en"
  front-matter-spacing: 1.5em,
  front-matter-margin: 2.0em,
  // 見出し Headings
  heading-abstract: [*Abstract--*],
  heading-keywords: [*Keywords*: ],
  heading-bibliography: [参　考　文　献],
  heading-appendix: [付　録],
  // フォントサイズ Font size
  font-size-title: 16pt,
  font-size-title-en: 12pt,
  font-size-authors: 12pt,
  font-size-authors-en: 12pt,
  font-size-abstract: 10pt,
  font-size-heading: 12pt,
  font-size-main: 10pt,
  font-size-bibliography: 9pt,
  // 補足語 Supplement
  supplement-image: [図],
  supplement-table: [表],
  supplement-separator: [: ],
  // 番号付け Numbering
  numbering-headings: "1.1",
  numbering-equation: "(1)",
  numbering-appendix: "A.1", // #show: appendix.with(numbering-appendix: "A.1") の呼び出しにも同じ引数を与えてください。
)


// --- Functions ---
#let citet(..citation) = {
  cite(..citation, form: "prose")
}


= はじめに

== ごあいさつ

こんにちは、これは#citet(<YongYe2025LuErDaoFangYanFuHeMingCiakusentonoXinJiuBiJiao>)による日本語の学会論文テンプレートです @YongYe2025LuErDaoFangYanFuHeMingCiakusentonoXinJiuBiJiao。


#bibliography(
  "../../../static/references.bib",
)
