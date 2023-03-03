;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "Ryan Kalysten"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
(setq doom-font (font-spec :family "ProggyVector" :size 18))
(setq doom-variable-pitch-font (font-spec :family "ETBembo" :size 28))
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-manegarm)

;; Doom theme for teemacs
(setq doom-themes-treemacs-theme 'doom-colors) ; use the colorful treemacs theme
;;  (doom-themes-treemacs-config)

;; Make full screen on startup
;; Transparent window
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(set-frame-parameter (selected-frame) 'alpha '(90 . 95))
(add-to-list 'default-frame-alist '(alpha . (85 . 95)))

;; custom banner
;;(setq fancy-splash-image (concat doom-private-dir "circuit-board-tree.png"))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Nextcloud/Documents/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Set up path for language checiking
(setq langtool-language-tool-jar "~/.local/share/languagetool/LanguageTool-6.1-SNAPSHOT/languagetool-commandline.jar")
      (setq langtool-default-language "en-US")
      (require 'langtool)

;;ggtags
(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
              (ggtags-mode 1))))

;; treemacs highlighting
(add-hook
'treemacs-mode-hook
 (defun channge-hl-line-mode ()
  (setq-local hl-line-face 'region)
   (overlay-put hl-line-overlay 'face hl-line-face)
   (treemacs--setup-icon-background-colors)))


;;(window-system)

;; Org-roam setup
;; Org-habit
  (use-package org-habit)
  (add-to-list 'org-modules 'org-habit)
  (setq org-habit-graph-column 60)

(add-hook 'org-mode-hook 'variable-pitch-mode t)


(setq org-roam-directory (file-truename "~/Nextcloud/Haven/Personal Resources/7. Intellectual/Org_roam_notes/"))
(setq find-file-visit-truename t
      org-roam-db-autosync-mode t
      org-roam-complete-everywhere t)
(add-to-list 'display-buffer-alist
             '("\\*org-roam\\*"
               (display-buffer-in-direction)
               (direction . right)
               (window-width . 0.33)
               (window-height . fit-window-to-buffer)))

;; org-roam templates
(setq org-roam-capture-templates
      '(
        ("d" "default" plain "%?"
         :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                            "#+title: ${title}\n") :unnarrowed t)
        ("p" "permaculture" plain "%?"
         :target (file+head "~/Nextcloud/Haven/Personal Resources/7. Intellectual/Org_roam_notes/PDC_notes/%<%Y%m%d%H%M%S>-${slug}.org"
                            "#+title: ${title}\n#+filetags: draft: %^g") :unnarrowed t)
        ("w" "work" plain "%?"
         :target (file+head "FleetingNotes/%<%Y%m%d%H%M%S>-${slug}.org"
                            "#+title: ${title}\n") :unnarrowed t)
        ("P" "personal" plain "%?"
         :target (file+head "Inbox/%<%Y%m%d%H%M%S>-${slug}.org"
                            "#+title: ${title}\n#+filetags: %^g \n") :unnarrowed t)
        ("d" "Needs Yields" plain "%?"
         :target (file+head "~/Nextcloud/Haven/Personal Resources/7. Intellectual/Org_roam_notes/Needs_yields/%<%Y%m%d%H%M%S>-${slug}.org"
                            "#+title: ${title}\n#+filetags: draft: %^g") :unnarrowed t)
        ("t" "Needs Yields" plain "%?"
         :target (file+head "~/Nextcloud/Haven/Personal Resources/7. Intellectual/Org_roam_notes/test/%<%Y%m%d%H%M%S>-${slug}.org"
                            "#+title: ${title}\n#+filetags: draft: %^g") :unnarrowed t)
        ("b" "Bio-Dome Power" plain "%?"
         :target (file+head "~/Nextcloud/Haven/Personal Resources/7. Intellectual/Org_roam_notes/bio_power/%<%Y%m%d%H%M%S>-${slug}.org"
                            "#+title: ${title}\n#+filetags: draft: %^g") :unnarrowed t)

        )
      )

;; Take note without going to note
(defun org-roam-node-insert-immediate (arg &rest args)
  (interactive "P")
  (let ((args (cons arg args))
        (org-roam-capture-templates (list (append (car org-roam-capture-templates)
                                                  '(:immediate-finish t)))))
    (apply #'org-roam-node-insert args)))
(map!
 :leader
 :desc "Insert node without going to node"
 "n r I" #'org-roam-node-insert-immediate)

(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org-roam ;; or :after org
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
;;  :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))





;; ORG MODE
;; Must do this so the agenda knows where to look for my files
(setq org-agenda-files '("~/Nextcloud/Documents/org"))

;; When a TODO is set to a done state, record a timestamp
(setq org-log-done 'time)

;; Follow the links
(setq org-return-follows-link  t)

;; Associate all org files with org mode
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

;; Make the indentation look nicer
(add-hook 'org-mode-hook 'org-indent-mode)


;; Hide the markers so you just see bold text as BOLD-TEXT and not *BOLD-TEXT*
(setq org-hide-emphasis-markers t)

;; Wrap the lines in org mode so that things are easier to read
(add-hook 'org-mode-hook 'visual-line-mode)

;;Custom headers
(custom-set-faces
  '(org-level-1 ((t (:inherit outline-1 :height 1.5))))
  '(org-level-2 ((t (:inherit outline-2 :height 1.3))))
  '(org-level-3 ((t (:inherit outline-3 :height 1.2))))
  '(org-level-4 ((t (:inherit outline-4 :height 1.1))))
  '(org-level-5 ((t (:inherit outline-5 :height 1.0))))
)

(setq org-capture-templates
      '(
        ("j" "Work Log Entry"
         entry (file+datetree "~/Nextcloud/Documents/org/work-log.org")
         "* %?"
         :empty-lines 0)
        ))

;; VDIFF
(require 'vdiff)
(require 'evil)
(evil-define-key 'normal vdiff-mode-map "," vdiff-mode-prefix-map)


(setq lsp-clients-clangd-args '("-j=3"
				"--background-index"
				"--clang-tidy"
				"--completion-style=detailed"
				"--header-insertion=never"
				"--header-insertion-decorators=0"))
(after! lsp-clangd (set-lsp-priority! 'clangd 2))

(setq lsp-enable-file-watchers nil)
