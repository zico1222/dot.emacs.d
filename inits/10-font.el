; 半角英字設定
(set-face-attribute 'default nil :family "Inconsolata" :height 140)

; 全角かな設定
(set-frame-font  (frame-parameter nil 'font)
                  'japanese-jisx0208
                  (font-spec :family "IPAゴシック" :size 16))
; 半角ｶﾅ設定
(set-frame-font (frame-parameter nil 'font)
                  'katakana-jisx0201
                  (font-spec :family "IPAゴシック" :size 16))
