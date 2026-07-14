;;; modules/home/doom-config/themes/doom-oxocarbon-theme.el -*- lexical-binding: t; -*-

;;; doom-oxocarbon-theme.el --- oxocarbon port for Doom Emacs -*- lexical-binding: t; -*-
;;
;; Author: Roman Todd (roman-xo)
;; Maintainer: Roman Todd
;; Source: https://github.com/roman-xo/doom-oxocarbon
;;
;;; Commentary:
;; A Doom-native port of the oxocarbon Neovim theme.
;;
;;; Code:

(require 'doom-themes)

;;; Variables

(defgroup doom-oxocarbon-theme nil
  "Options for the `doom-oxocarbon' theme."
  :group 'doom-themes)

(defcustom doom-oxocarbon-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'doom-oxocarbon-theme
  :type 'boolean)

(defcustom doom-oxocarbon-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'doom-oxocarbon-theme
  :type 'boolean)

(defcustom doom-oxocarbon-comment-bg doom-oxocarbon-brighter-comments
  "If non-nil, comments will have a subtle, darker background. Enhancing their
legibility."
  :group 'doom-oxocarbon-theme
  :type 'boolean)

(defcustom doom-oxocarbon-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line. Can be an integer to
determine the exact padding."
  :group 'doom-oxocarbon-theme
  :type '(choice integer boolean))


;;; Theme definition

(def-doom-theme doom-oxocarbon
    "A dark theme using the oxocarbon color palette"

  ;; name        default   256       16
  ((bg         '("#111111" nil       nil            ))  ; base00
   (bg-alt     '("#262626" nil       nil            ))  ; base01
   (base0      '("#0d0d0d" "black"   "black"        ))
   (base1      '("#161616" "#1e1e1e" "brightblack"  ))
   (base2      '("#1f1f1f" "#2e2e2e" "brightblack"  ))
   (base3      '("#262626" "#262626" "brightblack"  ))  ; base01
   (base4      '("#393939" "#393939" "brightblack"  ))  ; base02
   (base5      '("#525252" "#525252" "brightblack"  ))  ; base03
   (base6      '("#6f6f6f" "#6b6b6b" "brightblack"  ))
   (base7      '("#a0a0a0" "#979797" "brightblack"  ))
   (base8      '("#f2f2f2" "#dfdfdf" "white"        ))  ; base05
   (fg         '("#f2f2f2" "#f2f2f2" "brightwhite"  ))  ; base05
   (fg-alt     '("#d0d0d0" "#d0d0d0" "white"        ))  ; base04

   (grey       base5)
   (red        '("#ee5396" "#ee5396" "red"          ))  ; base10-red
   (orange     '("#ff9b5e" "#D08770" "brightred"    ))  ; custom warm orange
   (green      '("#42be65" "#42be65" "green"        ))  ; base13-green
   (blue       '("#78a9ff" "#78a9ff" "brightblue"   ))  ; base09-blue
   (yellow     '("#ECBE7B" "#ECBE7B" "yellow"       ))  ; doom-one yellow
   (violet     '("#be95ff" "#be95ff" "brightmagenta"))  ; base14-purple
   (teal       '("#08bdba" "#44b9b1" "brightgreen"  ))  ; base07-turquoise
   (dark-blue  '("#4589ff" "#2257A0" "blue"         ))  ; darker blue variant
   (magenta    '("#ff7eb6" "#ff7eb6" "magenta"      ))  ; base12-pink
   (cyan       '("#3ddbd9" "#3ddbd9" "brightcyan"   ))  ; base08-cyan
   (dark-cyan  '("#33b1ff" "#33b1ff" "cyan"         ))  ; base11-light-blue

   ;; face categories -- required for all themes
   (highlight      cyan)
   (vertical-bar   (doom-darken bg 0.25))
   (selection      base4)
   (builtin        violet)
   (comments       (if doom-oxocarbon-brighter-comments base5 base5))
   (doc-comments   dark-cyan)
   (constants      magenta)
   (functions      magenta)
   (keywords       blue)
   (methods        magenta)
   (operators      blue)
   (type           blue)
   (strings        dark-cyan)
   (variables      fg)
   (numbers        dark-cyan)
   (region         base4)
   (error          red)
   (warning        yellow)
   (success        green)
   (vc-modified    cyan)
   (vc-added       green)
   (vc-deleted     red)

   ;; custom categories
   (hidden     `(,(car bg-alt) "black" "black"))
   (-modeline-bright doom-oxocarbon-brighter-modeline)
   (-modeline-pad
    (when doom-oxocarbon-padded-modeline
      (if (integerp doom-oxocarbon-padded-modeline) doom-oxocarbon-padded-modeline 4)))

   (modeline-fg     fg)
   (modeline-fg-alt base5)
   (modeline-bg
    (if -modeline-bright
        (doom-darken base3 0.1)
      base1))
   (modeline-bg-l
    (if -modeline-bright
        (doom-darken base3 0.05)
      base1))
   (modeline-bg-inactive   `(,(doom-darken (car bg-alt) 0.05) ,@(cdr base1)))
   (modeline-bg-inactive-l (doom-darken bg 0.1)))


  ;;;; Base theme face overrides
  (((default &override) :background bg :foreground fg)
   ((font-lock-comment-face &override)
    :background (if doom-oxocarbon-comment-bg (doom-lighten bg 0.05)))
   ((line-number &override) :foreground base5)
   ((line-number-current-line &override) :foreground fg)
   (hl-line :background (doom-blend base3 bg 0.4))
   (mode-line
    :background modeline-bg :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   (mode-line-inactive
    :background modeline-bg-inactive :foreground modeline-fg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive)))
   (mode-line-emphasis :foreground (if -modeline-bright base8 highlight))

   ;;;; Font rendering fixes
   ((bold &override) :weight 'bold)
   ((italic &override) :slant 'italic)
   ((bold-italic &override) :weight 'bold :slant 'italic)

   ;;;; css-mode <built-in> / scss-mode
   (css-proprietary-property :foreground orange)
   (css-property             :foreground fg)
   (css-selector             :foreground red)
   ;;;; doom-modeline
   (doom-modeline-bar :background (if -modeline-bright modeline-bg highlight))
   ;;;; elscreen
   (elscreen-tab-other-screen-face :background base3 :foreground base1)
   ;;;; markdown-mode
   (markdown-markup-face :foreground base5)
   (markdown-header-face :inherit 'bold :foreground red)
   ((markdown-code-face &override) :background (doom-darken bg 0.1))
   ;; outline <built-in>
   ((outline-1 &override) :foreground red :weight 'ultra-bold)
   ((outline-2 &override) :foreground fg)
   ((outline-3 &override) :foreground blue)
   ((outline-4 &override) :foreground teal)
   ((outline-5 &override) :foreground cyan)
   ((outline-6 &override) :foreground dark-cyan)
   ((outline-7 &override) :foreground green)
   ((outline-8 &override) :foreground fg)
   ;;;; org <built-in>
   (org-block            :background (doom-darken bg-alt 0.04))
   (org-block-begin-line :foreground base5 :slant 'italic :background (doom-darken bg 0.04))
   (org-ellipsis         :underline nil :background bg :foreground red)
   ((org-quote &override) :background base1)
   (org-hide :foreground bg)
   ;; org meta/property keywords
   (org-meta-line :foreground base5)
   (org-document-title :foreground cyan :weight 'bold)
   (org-document-info :foreground cyan)
   (org-document-info-keyword :foreground base5)
   (org-special-keyword :foreground cyan)
   (org-property-value :foreground fg)
   (org-drawer :foreground cyan)
   ;; org-level faces matching oxocarbon with proper bold
   ((org-level-1 &override) :foreground red :weight 'bold)
   ((org-level-2 &override) :foreground fg :weight 'bold)
   ((org-level-3 &override) :foreground blue :weight 'bold)
   ((org-level-4 &override) :foreground teal :weight 'bold)
   ((org-level-5 &override) :foreground cyan :weight 'bold)
   ((org-level-6 &override) :foreground dark-cyan :weight 'bold)
   ((org-level-7 &override) :foreground green :weight 'bold)
   ((org-level-8 &override) :foreground violet :weight 'bold)
   ;; org TODO keywords
   (org-todo :foreground green :weight 'bold)
   (org-done :foreground green :weight 'bold)
   ;; org headlines (the text after the stars and TODO)
   (org-headline-done :foreground base5 :weight 'normal :strike-through t)
   ;;;; solaire-mode
   (solaire-mode-line-face
    :inherit 'mode-line
    :background modeline-bg-l
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-l)))
   (solaire-mode-line-inactive-face
    :inherit 'mode-line-inactive
    :background modeline-bg-inactive-l
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive-l)))
   ;;;; solaire-mode - disable background alternation
   (solaire-default-face :inherit 'default :background bg)
   (solaire-hl-line-face :background (doom-blend base3 bg 0.4))
   ;;;; dired
   (dired-directory :foreground blue)
   (dired-marked :foreground magenta)
   (dired-symlink :foreground cyan)
   (dired-header :foreground red :weight 'bold))

  ;;;; Base theme variable overrides
  ;; ()
  )

;;; doom-oxocarbon-theme.el ends here
