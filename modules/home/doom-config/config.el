;; user config
(setq user-full-name "olivia"
      user-mail-address "liv@liv.town")

;; appearance
(setq doom-theme 'doom-oxocarbon)
(setq doom-font (font-spec :family "scientifica" :size 24))
(after! doom-themes
  (custom-set-faces!
    '(default :foreground "#bbc2cf")))
(setq display-line-numbers-type t) ;; `nil', `t' or `relative'.

;; org/roam
(setq org-directory "~/Notes/org/")
(setq org-roam-directory (file-truename "~/Notes/org/roam/"))
(setq org-roam-file-extension '("org"))
(setq org-roam-node-display-template (concat "${type:15} ${title:*} " (propertize "${tags:10}" 'face 'org-tag)))

(setq org-agenda-files
      (list (concat org-directory "tasks.org")
            (concat org-directory "notes.org")
            (concat org-directory "journal.org")))

;; bindings
(map! )
(define-key evil-normal-state-map (kbd "C-k") 'centaur-tabs-forward) ; (define-key evil-normal-state-map (kbd "") 'centaur-tabs-forward)
(define-key evil-normal-state-map (kbd "C-j") 'centaur-tabs-backward) ; (define-key evil-normal-state-map (kbd "") 'centaur-tabs-backward)

;; treesitter
(after! treesit
  (setq treesit-language-source-alist
        '((typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src" nil nil)
          (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src" nil nil))))
(use-package typescript-ts-mode
  :mode (("\\.ts\\'" . typescript-ts-mode)
         ("\\.tsx\\'" . tsx-ts-mode))
  :config
  (add-hook! '(typescript-ts-mode-hook tsx-ts-mode-hook) #'lsp!))


      ;;    (require 'org-caldav)
      ;;
      ;;    (setq org-caldav-server-url "https://plan.liv.town/")
      ;;    (setq org-caldav-password "your-password")
      ;;    (setq org-caldav-email-address "your-email@domain.com")
      ;;    (setq org-caldav-calendars '(("primary" . "https://your-domain.com/caldav/username/calendar/")))
      ;;    (setq org-caldav-inbox-calendar "primary")
      ;;    (setq org-caldav-auth-method 'basic)
      ;;    (setq org-caldav-sync-interval 300) ; Sync every 5 minutes
      ;;    (setq org-default-calendar "primary")
      ;;
      ;;    ;; Function to manually sync calendars
      ;;    (defun caldav-sync ()
      ;;      "Sync all CalDAV calendars."
      ;;      (interactive)
      ;;      (org-caldav-sync))
      ;;
      ;;    ;; Key binding for manual sync
      ;;    (global-set-key (kbd "C-c c") 'my-caldav-sync)
      ;;
      ;;    ;; Optional: Set up org-caldav logging
      ;;    (setq org-caldav-log-level 'info)
