# book_a_lunch

**ポリテクセンター向けランチ予約管理プラットフォーム**

## 概要 (Overview)
「BookaLunch」は、ポリテクセンターにおけるアナログな弁当予約プロセスをデジタル化し、ユーザー体験（UX）を劇的に改善するために開発された予約管理アプリケーションです。

## 開発の背景と課題 (Problem Statement)
ポリテクセンターでは、平日毎日日替わりのお弁当（1種類）が販売されており、3つの業者がローテーションで担当しています。しかし、既存のアナログな運用には以下の深刻なユーザビリティの問題がありました。

1.  **極端に短い予約可能時間**
    *   翌日以降の弁当を買うには「前日の13時まで」に予約が必要ですが、その予約受付は「お弁当販売中の45分間（12:00〜12:45）」に限定されています。
2.  **心理的な摩擦 (Social Friction)**
    *   販売業者の目の前で予約台帳に記入する必要があるため、業者の好みや選定において心理的な気遣いが発生します。
3.  **情報の不透明性**
    *   メニュー情報は「金曜日に翌週分が物理的な掲示板に張り出される」のみです。
    *   運営側の貼り忘れも散見され、メニュー不明のまま「ブラインド予約」を強いられるケースが発生しています。

## ソリューション (Solution)
**「手元で、いつでも、メニューを見ながら」**

本アプリケーションは、物理的な制約と心理的な障壁を取り除きます。

*   **Time Free:** 45分間の販売時間を待つことなく、好きなタイミングで予約が可能。
*   **Stress Free:** 業者に対面することなく、デジタル上で完結。
*   **Information:** 手元のデバイスで確実にメニューを確認してから注文可能。

## 技術選定とロードマップ (Technology & Roadmap)
本プロジェクトは、モダンな開発環境（VS Code）の習得と実践を兼ねてスタートしました。

*   **Phase 1 (Current):** Flutter Webによるブラウザベースの予約システム構築。
*   **Phase 2 (Future):** 同等の機能を持つモバイルアプリ（iOS/Android）への展開。

---

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)
