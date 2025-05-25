# 加载包
install.packages("plspm")
install.packages("semPlot")
install.packages("Hmisc")
library(plspm)
library(readxl)

# 导入Excel数据（假设文件名为"soil_data.xlsx"）
Path_data <- read_excel("C:/Users/leaderkk/Desktop/冗余.xlsx") 
Path_data <- as.data.frame(Path_data)  # 转换tibble为data.frame
rownames(Path_data) <- NULL           # 清除行名

# 定义潜变量列表（保持与数据列名一致）
mm <- list(
  演替阶段 = c("演替阶段"),       # 外生潜变量
  土壤性质 = c("TP", "SOM"),
  根系特征 = c("RLD", "EEGRSP"),
  入渗性能 = c("染色面积比", "总通道数", "优先流", "基质流")
)

# 路径矩阵（体现层级因果）
path <- matrix(
  c(0, 0, 0, 0,
    1, 0, 0, 0,    # 土壤功能 ← 演替 + 土层
    1, 1, 0, 0,    # 根系特征 ← 演替 + 土层（新增演替→根系）
    0, 1, 1, 0),   # 入渗性能 ← 土壤功能 + 根系特征
  nrow = 4,
  byrow = TRUE,
  dimnames = list(names(mm), names(mm))
)
pls_model_updated <- plspm(Path_data, path, mm, modes = rep("A",4))
summary(pls_model_updated)
plot(pls_model_updated )






