# Automated Metabolite Identification System for Clinical Mass Spectrometry 🧬

## 📌 Project Summary
To address the sensitivity limitations of traditional algorithms (e.g., Cosine Similarity) in complex clinical matrices, this pipeline automates metabolite identification by integrating **Spectral Entropy** measures. This approach optimizes the detection of subtle fragment characteristics, bridging the gap between raw MS data and clinical decision support.

---

## 🛠 Implementation Details
* **Automated ETL Pipeline**: Engineered a **Regex-based** parser to transform semi-structured HMDB records into standardized, analysis-ready formats for high-throughput computation.
* **Spectral Entropy Analytics**: Implemented entropy-based similarity measures to enhance identification precision. Unlike traditional methods, this algorithm effectively handles spectral noise and dynamic range in clinical samples, providing more robust chemical fingerprinting.
* **Analytical Visualization**: Developed an automated **Head-to-Tail plotting** module to facilitate rapid visual validation and streamline the clinical reporting workflow.

---

## 📂 Directory Structure
* `data/`: Raw MSP files from HMDB and sample user CSV files.
* `results/`: Automated output directory for high-resolution Head-to-Tail plots.
* `MS_similarity_calculation.R`: Main analytic script with built-in environment portability.
* `Metabolite_ID.Rproj`: R project configuration for seamless environment consistency.

---

## ⚙️ Quick Start
1. **Clone** the repository and open `Metabolite_ID.Rproj`.
2. **Ensure** R packages `tidyverse` and `msentropy` are installed.
3. **Run** the main script `MS_similarity_calculation.R`.
4. **Check** the `results/` folder for visual identification reports.

---

## 🏗 Prerequisites
To run this pipeline, you need **R (>= 4.0.0)** and the following libraries:

```R
install.packages(c("tidyverse", "msentropy"))
```

## 📊 Results (Visuals)
The pipeline automatically generates Head-to-Tail plots, allowing for rapid visual confirmation between the query spectrum (Top) and the HMDB reference (Bottom).

## 📄 Full Report
For detailed scientific methodology and case studies, please refer to the [Technical Report (PDF)](./Technical_Report_Metabolite_ID.pdf).

## Methodology & References
The spectral similarity scoring and data alignment in this pipeline are implemented based on the methodologies described in:

Li, Y., Kind, T., Folz, J. et al. Spectral entropy outperforms MS/MS dot product similarity for small-molecule compound identification. Nat Methods 18, 1524–1531 (2021). https://doi.org/10.1038/s41592-021-01331-z
