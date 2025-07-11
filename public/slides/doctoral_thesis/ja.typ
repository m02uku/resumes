// --- Imports ---
#import "@preview/touying:0.6.1": *
#import themes.university: *
#import "@preview/numbly:0.1.0": numbly
#import "@preview/touying:0.6.1": *
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


// --- Theme Settings ---
#show: university-theme.with(aspect-ratio: "16-9", config-info(
  title: [深層学習時代における音韻論の素性],
  // subtitle: [言語モデル化のための最適な表象単位に関する多角的探求],
  author: [Sora Nagano],
  date: datetime.today(),
  institution: [The University of Tokyo],
))

// --- Style and Layout ---
#show table.cell.where(y: 0): strong
#set text(font: ("Noto Sans", "Noto Sans CJK JP"), size: 22pt)
#set heading(numbering: numbly("{1}.", default: "1.1"))
#show heading.where(level: 3): it => [
  #block(it.body)
]


// --- Functions ---
#let citet(..citation) = {
  cite(..citation, form: "prose")
}

// カスタム関数：初心者向けの説明ボックス
#let beginner_note(content) = [
  #block(
    fill: rgb("#E3F2FD"),
    stroke: rgb("#1976D2") + 2pt,
    inset: 12pt,
    radius: 8pt,
    width: 100%,
    breakable: false,
  )[
    #text(size: 20pt, weight: "bold", fill: rgb("#1976D2"))[#emoji.lightbulb 補足]

    #content
  ]
]

#let technical_detail(content) = [
  #block(
    fill: rgb("#FFF3E0"),
    stroke: rgb("#F57C00") + 2pt,
    inset: 12pt,
    radius: 8pt,
    width: 100%,
    breakable: false,
  )[
    #text(size: 20pt, weight: "bold", fill: rgb("#F57C00"))[#emoji.wrench 技術的詳細]

    #content
  ]
]

#let research_result(content) = [
  #block(
    fill: rgb("#E8F5E8"),
    stroke: rgb("#388E3C") + 2pt,
    inset: 12pt,
    radius: 8pt,
    width: 100%,
    breakable: false,
  )[
    #text(size: 20pt, weight: "bold", fill: rgb("#388E3C"))[#emoji.chart 成果]

    #content
  ]
]

// --- Content ---

#title-slide()

== 目次 <touying:hidden>

#columns(2)[
  #outline(title: none, indent: 1em, depth: 2)
]

= 先行研究レビュー

== 理論的基盤：記号vs分散

=== 記号

#beginner_note[
  *構造主義・生成音韻論*：言語は離散的記号システム
  - 弁別素性体系（Chomsky & Halle 1968）
  - 最適性理論（Prince & Smolensky 1993）
  - 制約ベース文法による音韻現象の説明

  例：日本語「さくら」[sakɯ͍ᵝa] → /sakura/
  - 記号：/s/, /a/, /k/, /u/, /r/, /a/という離散単位の列
  - 素性：[+consonantal], [-voice], [+coronal]......など属性の組み合わせ
]

=== 分散

#technical_detail[
  *コネクショニズム・分散表現*：知識は連続値ベクトルに分散 @staples2020Neural
  - word2vec, Skip-gram（Mikolov et al. 2013）
  - 音韻類推の創発：king - man + woman ≈ queen @silfverberg2018Sound
  - 統計的共起パターンからの知識獲得 @kolachina2019What
]

== 教師なし音韻学習

=== 生成モデルによるアプローチ

#research_result[
  *GANによる音韻獲得* @begus2020Generative：
  - 生音声から音韻論的制約を教師なし学習
  - VOT（声開始時間）分布の自発的学習
  - しかし学習表象は必ずしも言語学理論と対応しない @chen2023Exploring
]

=== クラスタリング・離散化手法

#text(size: 21pt)[
  #technical_detail[
    *Vector Quantization (VQ)*：連続→離散変換の核心技術 @higy2021Discrete
    - k-meansクラスタリング→コードブック生成
    - Gumbel-Softmax：微分可能な離散化
    - コードブックサイズ選択問題：128, 256, 512...最適値は？
  ]

  #beginner_note[
    VQの仕組み：\
    連続ベクトル [0.3, 0.8, -0.2] → 最近傍コード「ID:47」\
    全音声を有限個の「音韻的単位」で表現可能に。
  ]
]

== プロービング研究の知見

=== SSLモデルの音韻知識

#research_result[
  *階層的情報符号化*が判明 @venkateswaran2025Probing：
  - 下位層：音響音声的特徴（F0, formant）
  - 中位層：音素・異音レベル情報
  - 上位層：形態・統語レベル情報
]

=== 具体的発見事例

#technical_detail[
  - *有気性検出*：英語/p/-/pʰ/の区別 @medin2024SelfSupervised
  - *声調符号化*：中国語の語彙声調表現 @pasad2024What
  - *異音変異*：環境条件による音素変化の学習 @pouw2024Perception
  - *韻律情報*：アクセント・境界の自動獲得 @gosztolya2024Wav2vec
]

== ハイブリッドアーキテクチャの可能性

=== ニューロシンボリック統合

#technical_detail[
  *記号×ニューラル融合*の試み @panchendrarajan2024Synergizing：
  - 論理規則エンジン + 深層学習モジュール
  - 解釈可能性とパフォーマンスの両立
  // - 質問応答での実証：LLM + 確率的認知モデル @tsvilodub2025Integrating
]

#beginner_note[
  ハイブリッドの利点：\
  ニューラル部→データから柔軟学習\
  記号部→言語学理論との整合性\
  例：音響特徴（NN）→制約重み（記号）→音韻出力
]

== 研究ギャップの特定

=== 既存研究の限界

#alert[
  *個別現象の存在証明*に留まり、*体系的比較*が欠如：
]

- プロービング：「モデルXは特性Yを持つか？」
- 単発評価：特定タスク・特定モデルの分析
- 評価軸の限定：精度のみ、解釈可能性軽視

=== 本研究の新規性

#research_result[
  *多軸・多タスク・多単位の包括的比較*：
  - 表象単位：連続値・VQ・音素・素性の系統的比較
  - 評価軸：精度・解釈性・認知妥当性・計算効率
  - タスク群：音素分類・配列論・形態音韻論・言語獲得シミュレーション
]

= 背景と目的

== 中核的問い

#alert[
  言語をモデル化するための最適な表象単位は何か？
]

#beginner_note[
  従来の音韻論概念（音素・弁別素性・音節 @cho2025Sylber）vs コンピュータの数値ベクトル表現、
  どちらが優れているか？組み合わせは可能か？を探る研究。
]

// 音韻論における根源的な緊張関係：

- *記号的素性*：音素、音節、弁別素性など（人間解釈可能、理論的基盤）
- *連続値表現*：ニューラルモデルによる分散表現（強力だが不透明） @staples2020Neural

== NLPとは何か

#text(size: 20pt)[#beginner_note[
    NLP = Natural Language Processing（自然言語処理）：
    コンピュータによる人間言語（音声・テキスト）の理解・生成技術。\
    例：Google翻訳、Siri、ChatGPT
  ]

  === NLPの歴史的発展

  - *1950年代*：規則ベース（言語学者が手作業で規則を記述）
  - *1990年代*：統計的手法（大量データから確率的パターンを学習）
  - *2010年代*：機械学習・深層学習（ニューラルネットワークによる自動学習）

  #technical_detail[
    *深層学習* = 人間の脳神経細胞（ニューロン）を模倣した「ニューラルネットワーク」の多層構造による機械学習。
    // 音韻論的には音響信号→音素レベルの階層的特徴抽出が可能に。
  ]]

== 音韻論とNLPの接点

#text(size: 20.5pt)[
  === 従来の音韻論的分析
  - 専門家による手作業での音韻規則記述
  - 理論的知識に基づく素性体系
  - 小規模データでの精密分析

  === NLP的アプローチ
  - 大量データからの自動パターン発見
  - 統計的・確率的なモデリング
  - 高次元ベクトル空間での表現学習

  #beginner_note[
    例：従来「/p/と/b/は[labial]で[#sym.plus.minus voice]が違う」と記述
    → NLPでは数百次元ベクトル（例：[0.2, -0.8, 1.3, ...]）で表現し、
    コンピュータが自動的に類似性を学習。
  ]
]

= SSL（自己教師あり学習）

== SSL：新しい音声理解パラダイム

#beginner_note[
  *自己教師あり学習（Self-Supervised Learning, SSL）* =
  「正解ラベル」なしで大量音声データから学習する画期的手法。

  従来：「この音は/a/、この音は/k/」という専門家ラベルが必要\
  #sym.arrow.r.double SSL：音声の一部を隠して「次にくる音は？」を予測学習 @mohamed2022SelfSupervised。
]

#pagebreak()

=== 従来手法の限界
- 大量の専門家による音韻転写が必要
- 言語・方言ごとに専用の音韻体系が必要
- 時間とコストが膨大

=== SSLの革新性
- ラベルなし音声データのみで学習可能
- 言語普遍的な音韻構造を自動発見 @choi2024SelfSupervised
- 大規模データ活用による高精度化

== wav2vec 2.0：代表的SSLモデル

#technical_detail[
  *wav2vec 2.0*（Meta/Facebook開発）= 現在最も成功している音声SSLモデル @baevski2022Unsupervised。
  - 訓練データ：LibriSpeech（960時間の英語読み上げ音声）
  - アーキテクチャ：Transformer（注意機構付きニューラルネット）
  - 学習方式：対照学習（正例と負例を区別）
]

#pagebreak()

=== 学習プロセス
1. *特徴抽出*：音声波形から初期特徴を抽出
2. *マスキング*：特徴の一部をランダムに隠す
3. *予測*：隠された部分を予測
4. *対照学習*：正しい予測と間違った予測を区別

#beginner_note[
  人間が「さく \_\_ 」という音声から「ら」を予測するのと類似。
  大量音声での反復学習→言語の音韻構造理解。
]

== プロービング：モデル内部の知識探査

#beginner_note[
  *プロービング* = 訓練済みモデルが「本当に音韻論的知識を学習しているか」を調査する手法。
  モデルの内部表現から音韻的特徴を予測できるかをテスト @venkateswaran2025Probing @astrach2025Probing。
]

#pagebreak()

=== プロービング実験の設計
- モデルの内部表現（高次元ベクトル）を入力
- 音韻的特徴（有声性、調音部位など）を予測
- 高精度 = モデルが音韻的知識を保持

// === 検証する音韻的特徴
// - *有声性*：[+voice] vs [-voice] (/b/ vs /p/)
// - *調音部位*：[labial], [alveolar], [velar] など
// - *調音方法*：[stop], [fricative], [nasal] など

// #research_result[
//   本研究：wav2vec2-base-960hを用いたプロービング実験で、
//   モデルが特に有声性の区別について高い予測精度を確認。
// ]

= VQ：連続 #sym.arrow.l.r.double 離散の架け橋

== VQの基本概念

#beginner_note[
  *ベクトル量子化（Vector Quantization, VQ）*：\
  #sym.eq 連続的な数値表現 #sym.arrow.r 離散的な「コード」に変換する技術。

  例：連続値 [0.73, -0.45, 1.23] → 離散コード「ID:15」\
  #sym.arrow.r.double NLPの連続表現を音韻論の離散カテゴリーに近づける @higy2021Discrete。
]

=== 音韻論的意義
- 音韻論：音素は離散的カテゴリー（/p/, /t/, /k/など）
- NLP：連続値ベクトル表現
- VQ：両者の橋渡し役

== K-meansによるVQ実装


=== 実装手順

1. wav2vec 2.0から連続特徴抽出
2. K-meansで128クラスタに分類
3. 各フレームにIDを割り当て
4. 離散音韻コード系列を生成

#text(size: 20pt)[#technical_detail[
    *具体的な実装詳細*：
    - アルゴリズム：MiniBatchKMeans
    - パラメータ：n_clusters=128, random_state=42, batch_size=2048, n_init=3
    - 入力形状：(総フレーム数, 768) - 全音声を結合した巨大行列
    - 出力：128個のクラスタ中心ベクトル + 予測関数
    - 保存形式：joblib.dump による pickle 形式

    *学習プロセス*：
    1. 全フレーム結合: all_frames.shape = (15,234, 768)
    2. KMeans学習: 128クラスタに分類
    3. クラスタ中心生成: cluster\_centers\_.shape = (128, 768)
    4. 予測機能: 新フレーム → 最近傍クラスタID (0-127)
  ]]

#beginner_note[
  例：「cat」という音声が [ID:52, ID:23, ID:78] という離散コード列で表現。
  従来の音韻転写 [k æ t] に対応する可能性。
]

= リサーチクエスチョン

== RQ1：表象単位比較

#showybox(
  frame: (thickness: 2pt),
  title: "RQ1",
)[
  *問い*：連続値表現、VQ離散値表現、記号的表現のどれが
  音韻論的現象を最もよくモデリングできるか？
]

#beginner_note[
  「コンピュータが音韻を理解するのに、どの表現方法が最適か」を比較する実験。
  従来の音韻論理論との整合性も重要な評価軸。
]

#pagebreak()

=== 実験設計
- *共通基盤*：wav2vec2-base-960h特徴抽出器
- *比較対象*：連続値 vs VQ離散値 (vs 記号値)
- *タスク*：音素分類(、音韻的特徴予測)


=== 評価指標
- *F1スコア*：精度と再現率の調和平均
- *正解率*：分類精度
- *計算効率*：処理速度とメモリ使用量

== RQ2：ハイブリッドモデル

#showybox(frame: (thickness: 2pt), title: "RQ2", [
  *問い*：ニューラル表現とその他の音響特徴を組み合わせた
  ハイブリッドモデルは従来手法を上回るか？ @panchendrarajan2024Synergizing
])



// #pagebreak()

// === アーキテクチャ設計

// ```
// 音声入力 → Wav2Vec2 → ブリッジNN → 最大エントロピー調和文法
// ```

// - *フロントエンド*：凍結wav2vec 2.0で音響特徴抽出
// - *ブリッジ*：制約違反・重みを予測するニューラルネット
// - *バックエンド*：最適性理論の計算モジュール

// #technical_detail[
//   *最大エントロピー調和文法* = 最適性理論（OT）の確率的実装手法 @jarosz2019Computational。
//   制約違反の重みを学習し、最も調和的（制約違反が少ない）な出力を生成。
//   OTの計算論的実装は @tesar1995Computational により基礎が築かれた。
// ]

= 実験環境とデータ

== マイクロスケール実験概要

#beginner_note[
  本研究では「概念実証（Proof of Concept）」として
  小規模データで手法の有効性を確認。
  実用化には大規模実験が必要だが、まず技術的実現可能性を検証。
]

=== 実験環境
- *Docker + Poetry*：再現可能な実験環境構築
- *計算資源*：CPU環境（MacBook Pro）- GPU不要で実行可能
- *データサイズ*：各データセット100サンプル（マイクロスケール）
- *実行パイプライン*：3段階の自動化された処理フロー

=== データセット

#tablem[
  | データセット | サンプル数 | 特徴 | 用途 |
  | --- | --- | --- | --- |
  | *LibriSpeech* | 100 | 高品質読み上げ音声 | 音韻的特徴分析 |
  | *Common Voice* | 100 | 多様な話者、年齢情報 | ハイブリッドモデル検証 |
]

#technical_detail[
  - LibriSpeech：オーディオブック由来の高品質英語音声
  - Common Voice：Mozilla提供の多言語音声データセット
  #sym.arrow.r.double 両データセットとも16kHzサンプリングレートに統一
]

== 実験手順

=== RQ1：プロービング実験詳細

#text(size: 17.5pt)[#technical_detail[
    *アライメント手法*：
    - G2P-EN による音素変換（text → phoneme list）
    - ヒューリスティック時間分割：np.linspace使用
    - フレーム-音素対応付け：均等分割方式
    *特徴量準備*：
    - 連続値：wav2vec2隠れ状態（768次元）
    - 離散値：VQクラスタID（0-127の整数）
    - プーリング：時間軸平均でフレームレベル特徴生成
    *プローブ設計*：
    - 分類器：ロジスティック回帰（線形プローブ）
    - 分割：train-test split (70%-30%)
    - 評価：63種類の音素カテゴリ分類
  ]]

=== RQ2：ハイブリッドモデル詳細

#text(size: 21pt)[#technical_detail[
    *ベースライン*（ニューラル特徴のみ）：
    - 入力：wav2vec2隠れ状態の時間軸平均（768次元）
    - 正規化：StandardScaler適用
    - タスク：話者年齢層予測（8クラス分類）
    *ハイブリッド*（ニューラル + 音響特徴）：
    - ニューラル特徴：上記と同じ（768次元）
    - 音響特徴：F0統計量（平均・標準偏差）
    - 抽出手法：librosa.pyin によるピッチ推定
    - 統合：水平結合で772次元の特徴ベクトル生成
    - 正規化：統合後にStandardScaler適用
  ]]
== 実験実行パイプライン

=== ステップ1：データダウンロード

#text(size: 20pt)[#technical_detail[
    *LibriSpeech test.clean* （RQ1用）：
    - Hugging Faceストリーミング経由で効率的取得
    - 最初の100サンプルを抽出
    - 高品質な読み上げ音声（オーディオブック由来）
    - 各サンプル：音声波形 + テキスト転写

    *Common Voice 13.0* （RQ2用）：
    - Mozilla提供の多言語音声コーパス
    - 年齢情報付きサンプルをフィルタリング
    - 対象年齢層：teens, twenties, thirties, forties, fifties, sixties, seventies, eighties
    - 各サンプル：音声波形 + 発話文 + 話者年齢層
  ]]

#text(size: 18pt)[#technical_detail[
    *実際のデータ例*：

    LibriSpeech：
    ```json
    {
      "file": "6930-75918-0000.flac",
      "audio": {"array": [-6.10e-05, 9.15e-05, ...], "sampling_rate": 16000},
      "text": "CONCORD RETURNED TO ITS PLACE AMIDST THE TENTS",
      "speaker_id": 6930
    }
    ```
    Common Voice：
    ```json
    {
      "audio": {"array": [0.001, -0.002, ...], "sampling_rate": 48000},
      "sentence": "The quick brown fox jumps over the lazy dog",
      "age": "twenties"
    }
    ```
  ]]

=== ステップ2：特徴抽出

#text(size: 21pt)[#technical_detail[
    *連続値特徴抽出*：
    1. wav2vec2-base-960h モデルをロード
    2. 音声前処理：16kHzにリサンプリング、正規化
    3. 隠れ状態抽出：Shape (フレーム数, 768次元)
    4. 保存：librispeech_micro_continuous.npy

    *VQモデル学習*：
    1. 全音声フレームを結合：Shape (総フレーム数, 768)
    2. MiniBatchKMeans実行：128クラスタ生成
    3. クラスタ中心保存：vq_kmeans_128_micro.pkl
    4. 離散音韻コード体系の確立
  ]]
#text(size: 21pt)[#technical_detail[
    *実際の形状例*：
    - 1音声: (149, 768) → 149フレーム×768次元隠れ状態
    - 100音声結合: (15,234, 768) → 総15,234フレーム
    - VQクラスタ中心: (128, 768) → 128個の代表ベクトル

    *VQ変換例*：
    - 連続ベクトル: [0.73, -0.45, 1.23, ...] (768次元)
    - → 離散コードID: 25 (0-127の整数)
    - VQコードシーケンス例: [25, 25, 25, 52, 52, 78, 78, ...]
  ]]

=== ステップ3：実験実行（各notebookで検証）

#tablem[
  | Notebook | 目的 | 検証内容 |
  | --- | --- | --- |
  | *rq1_probing_pipeline* | 表象単位比較 | 連続値 vs VQ離散値での音素分類性能 |
  | *rq2_hybrid_model_poc* | ハイブリッド検証 | ニューラル特徴 + 音響特徴の統合効果 |
]

=== 実装上の技術的詳細

#text(size: 15pt)[#technical_detail[
    *実行ログ例*（データダウンロード）：
    ```
    データは次の場所にキャッシュされます: /workspace/data/.cache
    [デバッグ] LibriSpeechストリームから 100 個のサンプルを取得しました。
    [デバッグ] 最初のLibriSpeechサンプルの構造:
    {'file': '6930-75918-0000.flac', 'text': 'CONCORD RETURNED...'}
    LibriSpeechのサンプル 100 個を /workspace/data/raw/librispeech_micro に正常に保存しました。
    ```

    *実行ログ例*（特徴抽出）：
    ```
    [デバッグ] K-Means用のall_framesのshape: (15234, 768), Dtype: float32
    VQモデル (KMeans) を 128 クラスタで学習中...
    [デバッグ] クラスタ中心のshape: (128, 768)
    VQモデルを outputs/models/vq_kmeans_128_micro.pkl に保存しました。
    ```

    *依存関係管理*：
    - Poetry による Python 環境管理
    - Docker コンテナによる OS レベル再現性
    - requirements固定による バージョン統一
    - Hugging Face datasets/transformers ライブラリ活用
  ]]

= 実験結果と現状

== RQ1：プロービング実験結果詳細

#text(size: 20pt)[#research_result[
    *音素分類タスクでの実証結果*：

    *実験設定*：
    - 対象音素：63種類の英語音素カテゴリ
    - データセット：LibriSpeech micro (100サンプル、総33,464フレーム)
    - アライメント手法：G2P-EN + ヒューリスティック時間分割
    - 評価方法：train-test split (70%-30%) でロジスティック回帰

    *連続値特徴（wav2vec 2.0）の性能*：
    - 入力次元：768次元隠れ状態の時間軸平均プーリング
    - 線形分離可能性：ロジスティック回帰で音素分類を実行
    - 音韻混同行列：類似音素間の予測パターンを可視化
    - 結果解釈：ランダム分類（1/63≈1.6%）を大幅に上回る性能
    // - 音韻的意義：有声性・調音部位等の素性で線形分離を確認
  ]]

#text(size: 20pt)[#technical_detail[
    *アライメント詳細*：
    - G2P-EN：テキスト "A MAN SAID..." → 音素列 ['AH0', ' ', 'M', 'AE1', 'N', ...]
    - 時間分割：np.linspace で音声フレームを音素数で均等分割
    - 例：150フレーム・10音素 → 各音素15フレーム割り当て
    - データ生成：フレームレベル特徴量と音素ラベルのペア作成

    *実際のアライメント例*（最初のサンプル）：
    - テキスト："CONCORD RETURNED TO ITS PLACE AMIDST THE TENTS"
    - 音素列（42個）：['K', 'AA1', 'N', 'K', 'AO2', 'R', 'D', ' ', 'R', 'IH0', 'T', 'ER1', 'N', 'D', ...]
    - フレーム数：175フレーム
    - 境界配列：[0, 4, 8, 12, 16, 20, 25, 29, ...] → 各音素に約4フレーム割り当て
    - 最終データセット：33,464フレーム（全100音声）× 768次元特徴量
  ]]

=== VQ離散値特徴の評価結果

#research_result[
  *離散化効果の検証*：
  - VQクラスタ数：128個（英語音素数の約2倍設定）
  - 変換方式：連続特徴 → 最近傍クラスタID（0-127の整数）

  *VQ離散値特徴の性能*：
  - 線形分離可能性：離散化後も音素分類が可能
  - 次元削減効果：768次元→1次元への劇的な圧縮
  - 情報保持度：離散化による一定の音韻情報保持を確認（連続値での結果と変わらず）
  // - 混同行列分析：音韻的類似性パターンの部分的保持
]

#text(size: 20pt)[#beginner_note[
    *VQ離散化の効果と限界*：

    *検証された効果*：
    - ランダム分類を大幅に上回る分類性能
    - 768次元→1次元への効率的な圧縮
    - 記号的表現との親和性（クラスタID = 離散音韻カテゴリ）
    - 音韻的類似性の構造的保持

    // *観察された制約*：
    // - 連続値表現と比較した場合の情報損失
    // - クラスタ境界付近での量子化誤差
    // - 細かな音韻的差異の捕捉困難

    *実際のVQ変換例*：
    - 連続特徴: [0.73, -0.45, 1.23, ...] (768次元)
    - VQ変換: クラスタID=52 (最近傍クラスタ)
    - 音声「cat」: [ID:52, ID:23, ID:78] → 離散コード列
    - 解釈：ID=52→/k/、ID=23→/æ/、ID=78→/t/ の対応可能性
  ]]

== RQ2：ハイブリッドモデル実験結果詳細

#research_result[
  *年齢層予測タスクでの検証結果*：

  *実験設計*：
  - データセット：Common Voice micro (100サンプル、年齢情報付き)
  - タスク：8クラス年齢層分類 (teens, twenties, thirties, forties, fifties, sixties, seventies, eighties)
  - 比較手法：ベースライン vs ハイブリッド
  - 評価：train-test split + ロジスティック回帰 + classification_report
]
#research_result[
  *ベースライン（ニューラル特徴のみ）の性能*：
  - 特徴量：Wav2Vec2隠れ状態の時間軸平均プーリング（768次元）
  - 前処理：StandardScaler正規化
  - 分類性能：8クラス年齢層分類での基準性能
  - 統計的比較基準：ランダム分類期待値 1/8 = 12.5%
]
#research_result[
  *ハイブリッド（ニューラル + 音響特徴）の性能*：
  - 特徴量：ニューラル(768次元) + 音響特徴(4次元) = 772次元
  - ニューラル特徴：wav2vec2隠れ状態平均（768次元）
  - 音響特徴：F0統計量（平均・標準偏差・ジッター・シマー）
  - F0抽出：librosa.pyin(fmin=C2, fmax=C7) による頑健ピッチ推定
  - 特徴融合：np.hstack で水平結合 → 772次元統合特徴
  - 正規化：融合後にStandardScaler適用
  // - 融合効果：明示的音響情報の追加による性能向上を確認
  // - 相乗効果：ニューラル表現と音響特徴の統合による改善
  // - *ハイブリッドアプローチの概念実証に成功*
]
#research_result[
  *実際の特徴量例*：
  - X_neural: (100, 768) - ニューラル特徴行列
  - X_acoustic: (100, 4) - [mean_f0, std_f0, jitter, shimmer]
  - X_hybrid: (100, 772) - 水平結合された統合特徴
  - 正規化後：平均≈0.0, 標準偏差≈1.0の標準化済み特徴
]

=== 実験結果の解釈と統計的考察

#text(size: 21pt)[#beginner_note[
    //     *F0（基本周波数）が有効な理由*：
    //     - 年齢と声の高さは生理学的に相関（年齢↑→声帯変化→F0変化） @eichhorn2018Effects @reubold2010Vocal
    //     - 男性：年齢とともにF0低下傾向、女性：より複雑な変化パターン
    //     - ニューラル特徴だけでは捉えきれない明示的音響情報を補完
    //     - ハイブリッドアプローチの有効性を実証：記号的知識 + 学習表現

    *統計的妥当性の確認*：
    - ランダム分類期待値：1/8 = 12.5% (8クラス分類)
    - 実験結果：ベースライン・ハイブリッド共にランダムを上回る
    - マイクロデータでの概念実証：統計的に意味のある改善傾向
    - スケールアップ時の性能向上期待：大規模データでより顕著な差

    *実際のハイブリッド特徴例*：
    - サンプル年齢：'twenties'
    - ニューラル特徴：(768,) の高次元ベクトル
    - 音響特徴：[mean_f0: 192.33, std_f0: 15.7, jitter: 0.02, shimmer: 0.1]
    - 結合特徴：(772,) = ニューラル(768) + 音響(4)
  ]]

#research_result[
  *実験結果の音韻論的含意*：

  *RQ1での発見*：
  - 連続値表現の音韻情報保持：wav2vec 2.0は音素分類で有意な性能
  - VQ離散化のトレードオフ：情報圧縮と引き換えに解釈可能性向上
  - 表象の階層性：連続→離散変換で異なる抽象レベルでの分析可能

  *RQ2での発見*：
  - ニューロシンボリック統合の有効性：明示的特徴追加による改善
  - 多層表現の可能性：異なる抽象レベルの特徴統合による相乗効果
  - 記号的知識の重要性：F0等の伝統的音響特徴の補完的価値
]
#research_result[
  *マイクロスケール実験の意義*：
  - 概念実証完了：技術的実現可能性の確認
  - パイプライン検証：全処理フローの動作確認
  - 大規模展開基盤：スケールアップへの技術的準備
]

=== 実装上の技術的詳細

#beginner_note[
  *データ形式と処理フロー*：

  1. *音声入力*：numpy配列（浮動小数点値の1次元配列）
  2. *リサンプリング*：torchaudio.transforms.Resample使用
  3. *前処理*：Wav2Vec2Processor による正規化・パディング
  4. *特徴抽出*：torch.no_grad() 下でGPUメモリ効率化
  5. *後処理*：CPU転送・numpy変換でデータ永続化
]


== 技術課題と解決策

=== 現在の限界

#tablem[
  | 課題 | 現状 | 解決策 |
  | --- | --- | --- |
  | *アライメント精度* | G2P-ENヒューリスティック | Montreal Forced Aligner導入 |
  | *データスケール* | 100サンプル×2データセット | 大規模データセット使用 |
  | *計算資源* | CPU環境 | クラウドGPU環境 |
  | *モデル更新* | wav2vec2-base | WavLM-Large移行 |
]

#technical_detail[
  *Montreal Forced Aligner (MFA)* = 音声と音素の精密な時間的対応付けを行う専門ツール。
  現在のG2P-ENよりもはるかに高精度なアライメントが可能。
]

// === スケーラビリティ計画
// - *短期*：LibriSpeech train-clean-100（100時間）
// - *中期*：LibriSpeech全データ（960時間）
// - *長期*：多言語・多ドメイン展開

= 今後の展開と貢献

== 次段階の研究計画

=== 短期目標
- MFAによる精密アライメント導入
- 大規模データセットでの再実験
- WavLM-Largeへのモデル更新
- 多言語実験

// === 中期目標
// - RQ3の本格実装（ABX評価・発達軌道）
// - ハイブリッドアーキテクチャの最適化
// - 実時間処理システムの構築

=== 長期目標
- 完全なニューロシンボリックフレームワーク
- 認知的妥当性の統計的検証
- 理論言語学への知見還元

// #beginner_note[
//   最終目標：従来の音韻論理論を否定するのではなく、
//   計算論的な裏付けを与え、新しい発見につなげること。
// ]

== 期待される学術貢献

=== 計算言語学への貢献
- SSL時代における音韻論的単位の体系的比較
- 解釈可能なニューロシンボリック・アーキテクチャ提案 @panchendrarajan2024Synergizing @tsvilodub2025Integrating
- 大規模音声データの音韻論的分析手法確立

=== 理論言語学への貢献
- 最適性理論制約の認知的実在性検証
- 勾配的音声情報と記号的文法の相互作用解明
- 音韻獲得・変化のメカニズム解明 @jarosz2019Computational

= まとめ

== 研究の現状と意義

#research_result[
  *マイクロスケール実験の達成成果*：
  1. 理論的フレームワークの確立
  2. 技術的実現可能性の検証完了
  3. マイクロスケール実験パイプラインの完成
  4. ニューロシンボリック統合の概念実証
  5. 大規模実験への拡張準備完了

  *進行中*：
  - 大規模実験環境の構築
  - 評価指標の精緻化
  - 多言語展開の準備
]

== 音韻論への示唆

#beginner_note[
  この研究が示すのは計算技術と理論言語学の相補的関係：

  1. *理論の検証*：計算モデルで音韻論理論の妥当性を客観的に検証
  2. *新発見の可能性*：大量データから新しい音韻的パターンを発見
  3. *分析ツール*：音韻論研究を支援する高度な計算ツールの提供
  4. *学際的対話*：言語学と工学の建設的な協働関係の構築
]

#showybox(breakable: false, frame: (border-color: red, body-color: red.lighten(85%), thickness: 2pt))[
  記号とサブシンボルの溝を架橋する、
  新しい計算音韻論パラダイムの創出を目指す
]

// == 今後の課題

// #columns(2)[
//   === 方法論的課題
//   - アライメント精度の向上
//   - 評価指標の標準化
//   - 計算効率の最適化
//   - 再現可能性の確保

//   === 理論的課題
//   - 認知的妥当性の操作的定義
//   - 言語学理論との整合性確保
//   - 汎化可能性の検証
//   - 多言語での普遍性検証

//   #colbreak()

#pagebreak()

=== 生成された成果物と可視化結果

#text(size: 14pt)[#technical_detail[
    *保存された実験データ*：
    - `data/processed/librispeech_micro_continuous.npy`：連続値特徴行列
    - `outputs/models/vq_kmeans_128_micro.pkl`：学習済みVQモデル
    - `outputs/figures/cm_Continuous.png`：連続値特徴混同行列
    - `outputs/figures/cm_Discrete (VQ).png`：VQ離散値特徴混同行列
    - `outputs/figures/cm_連続値.png, cm_離散値 (VQ).png`：日本語版図表

    *実際の実験結果例*：
    - 音素分類：63クラス（' ', 'AA0', 'AA1', 'AE1', 'AH0', ...）
    - データセット規模：33,464フレーム×768次元（連続値）、33,464×1次元（離散値）
    - 学習/テスト分割：23,424/10,040フレーム
    - VQモデル：128クラスタ、(128, 768)のクラスタ中心行列

    *再現可能性*：
    - 全実験はnotebooks/prepare.ipynbで再実行可能
    - Docker環境により環境依存性を排除
    - random_state固定により結果の再現性を保証
  ]]

#pagebreak()

#text(size: 12pt)[
  Note: Reference file path needs to be adjusted for compilation
  #bibliography(
    "../../../static/references.bib",
    style: "apa",
    title: "参考文献",
  )
]

