install.packages("msentropy")
install.packages('tidyverse')
library(tidyverse)
library(stringr)
library(matrixsimilarity)
library(msentropy)
library(purrr)
library(ggplot2)

#建立資料庫
MSP_Path ="./data/HMDB.txt"

tmp = readLines(MSP_Path)
### 哪裡出現關鍵字，例如Name
sIndex_Name = grep("NAME:", tmp) #正規表示式，應該像是擷取文字信息的某個特徵並標示在第幾行
sIndex_PrecursorMZ = grep("PRECURSORMZ: ", tmp)
sIndex_PrecursorTYPE = grep("PRECURSORTYPE: ", tmp)
sIndex_NumPeaks = grep("Num Peaks: ", tmp)

#把冒號前的字串丟掉
Name = gsub('.*:' , "", x = tmp[sIndex_Name])
print(Name)
PrecursorMZ = gsub(pattern = ".*: ", "", x = tmp[sIndex_PrecursorMZ])

NumPeaks = as.numeric(gsub("Num Peaks: " ,"" , tmp[sIndex_NumPeaks]))


S = sIndex_NumPeaks + 1#第幾行開始有Numpeaks數值
E = sIndex_NumPeaks + NumPeaks#Numpeaks數值在第幾行結束?
pIndex = cbind(S, E)#透過column合併資料

i = 1
Spec = list()
for(i in 1:nrow(pIndex))
{
  sIndex = pIndex[i, "S"] : pIndex[i, "E"]#pIndex為column資料pIndex[i, "S"]表示第i層的S
  
  #stringr::str_split(tmp[sIndex], "\t")
  mz = as.numeric(gsub("\t.*", "", tmp[sIndex]))#tmp = readLines(MSP_Path),
  intensity = as.numeric(gsub(".*\t", "", tmp[sIndex]))
  Spec[[i]] = cbind(mz, intensity)
}


input_file <- "./data/user_input.csv"

if (file.exists(input_file)) {
  # 讀取使用者上傳的 CSV 檔
  user_data <- read.csv(input_file)
  
  # 轉換為演算法所需的矩陣格式
  ms_unknown <- as.matrix(user_data[, c("mz", "intensity")])
  message("成功載入使用者輸入數據。")
} else {
  # 如果沒偵測到檔案，則自動載入預設範例 (原本的數據)
  message("未偵測到 user_input.csv，載入預設範例數據。")
  ms_unknown <- matrix(
    c(108.889, 15.431, 113.407, 53.522, 114.285, 100.0, 
      114.536, 47.916, 136.499, 22.35,  136.876, 17.753, 
      154.447, 11.029, 155.451, 32.825, 155.577, 24.099), 
    nrow = 9, ncol = 2, byrow = TRUE,
    dimnames = list(NULL, c("mz", "intensity")))
}
#未知的compound

#計算entropy_similarity

## seq_along(Spec)創建一個序列，其長度與 Spec 列表相同。此序列將用於循環遍歷 Spec
##~ {...} 部分定義了一個匿名函數，該函數將應用於 Spec 列表中的每個元素
##[.x] 是 R 中一種特殊的運算符，用於根據索引訪問嵌套列表或數據框中的元素。在這種情況下，它與 Spec[[.x]] 相同，但更簡潔地用於匿名函數
similarity_Score <- map(seq_along(Spec), ~ { 
  calculate_entropy_similarity(
    peaks_a = ms_unknown,
    peaks_b = Spec[[.x]],
    ms2_tolerance_in_da = 0.01,
    ms2_tolerance_in_ppm = 10,
    clean_spectra = FALSE,
    min_mz = 0,
    max_mz = 1000,
    noise_threshold = 0,
    max_peak_num = 10
  )
})

#畫質譜比對圖
for(i in 1:length(Spec)){
    png(paste0("./results/plots/Match_", i,".png"), width  = 800, height = 800, units = "px" )  
    plot(ms_unknown[,1], ms_unknown[,2], type = "h",##h=histogram 
         xlab ="mz", ylab = "Intensity", ylim = c(-100, 100), lwd = 2,
         main = "Spectral Entropy Similarity")
    abline(h = 0)
    lines(Spec[[i]][,1],-Spec[[i]][,2], type ="h",
          col = 2, lwd = 2)
    mtext(paste0("Similarity Score:", similarity_Score[[i]]), side = 3, line = 1,adj =0)
    mtext(paste('black line: unknown','red line: reference',sep =' '),side = 1, line =1,adj =1,padj =1)
    dev.off()
  
}
