臨床代謝質體自動化鑑定系統 (Metabolite Identification Pipeline)
📌 專案背景與動機 (Motivation)
在精準醫療研究中，鑑定臨床檢體中的未知代謝體（Metabolites）是核心環節。傳統分析多仰賴 Dot Product 等基礎計算法，但在處理具備複雜背景雜訊的臨床檢體（如：糞便代謝質體）時，往往辨識精準度不足。
本專案開發一套基於 R 語言 的自動化分析 Pipeline，導入近年最先進的 Spectral Entropy (譜圖熵) 演算法，旨在提升物質判定的穩健性與效率，排除人工判讀之主觀誤差。

🚀 核心技術亮點 (Technical Highlights)
自動化 ETL 流程：利用正規表示式 (Regex) 解析非結構化 MSP 文本檔案，實現 2,355 筆代謝物數據之結構化轉換。
高效能批次運算：捨棄傳統 for 迴圈，採用 purrr::map_dbl 函數式編程實作大規模相似度比對，提升處理效能。
先進演算法實作：導入 msentropy 核心演算，於複雜背景下提供更精確的相似度評分 (Similarity Score)。
標準化視覺化校驗：自動篩選高信賴度（Score > 0.8）之結果，並產出專業 Head-to-Tail（首尾對照）質譜圖 供臨床判讀。

🛠 檔案結構 (Project Structure)
💻 快速執行 (Quick Start)
設定環境：確保已安裝 tidyverse 與 msentropy 套件。
準備資料：將 MSP 格式之資料庫檔案命名為 HMDB.txt 並置於 ./data/ 目錄下。
執行分析：

查看結果：系統將自動產出鑑定報告於 ./results/plots/ 路徑中。

📊 預期成果 (Output Example)
系統輸出的 Head-to-Tail 質譜圖 中：
黑色 (Upper)：未知檢體訊號。
紅色 (Lower)：資料庫標準品訊號。
Similarity Score：提供量化指標輔助臨床決策支撐。
