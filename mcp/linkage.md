# MCP Hub 联动

## 总体架构

```
Codex-Legal-CN-Judgment-Predictor (本仓库)
    │
    ├── 知识注入：读取 laubeing-droid/Claude-for-Legal-CN-to-Codex 本地安装的技能文件
    │   ├── ~/.codex/skills/references/law-semantic-tree.json
    │   ├── ~/.codex/skills/references/law-versions.json
    │   └── patches/guards/blocking-list.md
    │
    └── 工具调用：通过 Codex MCP 协议调用 MCP Hub 安装的工具
        ├── chineselaw → 案例检索 + 法规检索
        ├── 北大法宝 → 专业法律数据库
        └── 国家法规库 → 法条核验
```

## 具体联动方式

### 一、知识注入（自动）

SKILL.md 工作流第 1 步即加载 laubeing-droid/Claude-for-Legal-CN-to-Codex 知识库：

```
1. 读取 ~/.codex/skills/references/law-semantic-tree.json
   → 获取法条→要件→效果映射，用于法律适用推理

2. 读取 ~/.codex/skills/references/law-versions.json
   → 核验法条是否为现行有效版本

3. 读取 ~/.codex/skills/*/references/reasoning-template-zh.md
   → 加载对应领域的中国法推理模板（禁止 IRAC）
```

前提：laubeing-droid/Claude-for-Legal-CN-to-Codex 已通过 `install.ps1` 部署到 Codex。

### 二、MCP 工具调用（按阶段触发）

前提：MCP Hub 已安装并配置在 `~/.codex/config.toml`。

#### 阶段 1：事实抽取后 → 类案检索

```
调用 MCP 工具：chineselaw.search_similar_cases
输入：案由 + 核心事实关键词
输出：5 个最相似案例的案号 + 裁判要旨
用途：了解类案裁判倾向，标注在预测报告中
```

#### 阶段 2：法律适用辩论 → 法条核验

```
调用 MCP 工具：chineselaw.verify_law 或 国家法规库 MCP
输入：法律名称 + 条号
输出：法条现行文本 + 效力状态 + 修订历史
用途：确认引用的法条未被修订/废止
```

#### 阶段 3：对抗辩论中 → 双向类案搜索

```
原告方搜索：
  调用 MCP 工具，以原告胜诉关键词搜索类案
被告方搜索：
  调用 MCP 工具，以被告胜诉/减轻责任关键词搜索类案
用途：双方各取有利案例支撑论证
```

#### 阶段 4：自评阶段 → 类案偏离度

```
调用 MCP 工具：对比预测结果与检索到的类案实际判决
计算偏离度：预测方向 vs 类案多数意见
在自评报告中标注：
  ✅ 与类案趋势一致 / ⚠️ 与类案趋势有偏离（可能需复核）
```

### 三、降级策略

| 条件 | 策略 |
|:-----|:-----|
| MCP Hub 未安装 | 基于 laubeing-droid/Claude-for-Legal-CN-to-Codex 知识库法条文本工作，标注 `[无MCP-需核验]` |
| laubeing-droid/Claude-for-Legal-CN-to-Codex 未安装 | 降级为通用法律推理，标注 `[无知识库-法条可能不准确]` |
| 两者均未安装 | 框架仍可运行（纯 LLM 推理），但置信度自动降低一级 |

## 前置安装

```powershell
# 1. 安装知识库
git clone https://github.com/laubeing-droid/laubeing-droid/Claude-for-Legal-CN-to-Codex-to-Codex.git
cd laubeing-droid/Claude-for-Legal-CN-to-Codex-to-Codex
.\install.ps1

# 2. 安装 MCP Hub
git clone https://github.com/laubeing-droid/laubeing-droid/Codex-Claude-legal-cn-mcp-hub.git
cd laubeing-droid/Codex-Claude-legal-cn-mcp-hub
.\install.ps1

# 3. 安装本框架
git clone https://github.com/laubeing-droid/Codex-Legal-CN-Judgment-Predictor.git
# 将 SKILL.md 导入 Codex 技能目录即可使用
```