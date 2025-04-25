# Clear_Sheet

このプロジェクトは、SwiftUI を用いた **半透明なモーダルシート（Bottom Sheet）** の実装例です。ユーザーが画面下から引き出すように表示されるモーダルで、サイズの変更や内容の切り替え、アニメーションを伴った表示が可能です。

![イメージ]('Simulator Screenshot - iPhone 16 Pro - 2025-04-26 at 00.17.50.png')
## 特徴

- **ドラッグ操作で高さを変更可能**
- **表示高さに応じてコンテンツが切り替わる**
- **シートの背景は `ultraThinMaterial` による半透明デザイン**
- **シートの開閉にアニメーション付き**
- **閉じるボタン付き**
- **上部に持ち手バー（Capsule）を表示**

## 実装内容

### 1. `ContentView.swift`

- 地図 (`Map`) を背景に表示
- 「Open Sheet」ボタンを押すことで `BottomSheet` を表示
- シートの高さに応じて表示内容を切り替え：

  | 高さ | 表示される View         |
  |------|-------------------------|
  | ~300pt未満 | `SummaryInfoView()`     |
  | ~500pt未満 | `MediumArticleView()`   |
  | それ以上   | `WeatherView()`         |

- `bottomSheet()` モディファイアを使用し、カスタムモーダルを組み込み

### 2. `Clear_Sheet.swift`

#### `View.bottomSheet()` 拡張

```swift
func bottomSheet(
    isPresented: Binding<Bool>,
    height: BottomSheetHeight,
    minHeight: CGFloat = 100,
    maxHeight: CGFloat? = nil,
    content: @escaping (CGFloat) -> some View
)
```


---

## 使い方

`bottomSheet` モディファイアを使用することで、任意の View に対してカスタマイズ可能なボトムシートを表示できます。

### 基本的な使用例

```swift
.bottomSheet(
    isPresented: $isPresented,
    height: .fraction(0.6),
    minHeight: UIScreen.main.bounds.height * 0.2,
    maxHeight: UIScreen.main.bounds.height * 0.9
) { currentHeight in
    // 高さに応じて表示するビューを切り替える
    if currentHeight < 300 {
        SummaryInfoView()
    } else if currentHeight < 500 {
        MediumArticleView()
    } else {
        WeatherView()
    }
}
```

### 引数の説明

- `isPresented`: `Binding<Bool>` — シートの表示/非表示を制御するバインディング
- `height`: `BottomSheetHeight` — 初期のシートの高さ（`.fixed(CGFloat)` または `.fraction(CGFloat)`）
- `minHeight`: `CGFloat` — シートの最小高さ（ドラッグ時に縮む最大限）
- `maxHeight`: `CGFloat?` — シートの最大高さ（ドラッグ時に広がる上限）
- `content`: `(CGFloat) -> some View` — 現在の高さを引数として受け取り、表示するコンテンツを返すクロージャ

### `BottomSheetHeight` 型について

- `.fixed(CGFloat)`: 絶対値で高さを指定
- `.fraction(CGFloat)`: 画面高さに対する割合で指定（例：`.fraction(0.6)` は画面の60%）

---
