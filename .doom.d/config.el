(setq user-full-name "Ivan Trajkov"
      user-mail-address "itrajkov999@gmail.com")

(setq auth-sources '("~/.authinfo.gpg"))

(map! :map evil-motion-state-map "C-u" #'my/evil-scroll-up-and-center)
(map! :map evil-motion-state-map "C-d" #'my/evil-scroll-down-and-center)
(map! :map evil-normal-state-map "C-x" #'evil-numbers/dec-at-pt-incremental)
(map! :map evil-normal-state-map "C-a" #'evil-numbers/inc-at-pt-incremental)
(map! :map evil-normal-state-map "C--" #'doom/decrease-font-size)
(map! :map evil-normal-state-map "C-+" #'doom/increase-font-size)

(setq epg-pinentry-mode 'loopback)

(setq doom-font (font-spec :family "Iosevka Nerd Font Mono" :size 18))

(setq display-line-numbers-type 'relative)
(setq truncate-lines nil)
(setq scroll-margin 9)

;; (setq doom-theme 'doom-zenburn)
(setq doom-theme 'catppuccin)
(setq doom-modeline-height 5)

(setq org-directory "~/Documents/org")

(add-hook 'org-mode-hook #'+org-pretty-mode)

(custom-set-faces!
  '(outline-1 :weight extra-bold :height 1.25)
  '(outline-2 :weight bold :height 1.15)
  '(outline-3 :weight bold :height 1.12)
  '(outline-4 :weight semi-bold :height 1.09)
  '(outline-5 :weight semi-bold :height 1.06)
  '(outline-6 :weight semi-bold :height 1.03)
  '(outline-8 :weight semi-bold)
  '(outline-9 :weight semi-bold))

(custom-set-faces!
  '(org-document-title :height 1.2))

(setq org-agenda-deadline-faces
      '((1.001 . error)
        (1.0 . org-warning)
        (0.5 . org-upcoming-deadline)
        (0.0 . org-upcoming-distant-deadline)))

(setq org-fontify-quote-and-verse-blocks t)

(setq org-roam-dailies-directory "daily/")

(setq org-roam-dailies-capture-templates
      '(("d" "default" entry
         "* %?"
         :target (file+head "%<%Y-%m-%d>.org"
                            "#+title: %<%Y-%m-%d>\n"))))

(setq org-roam-capture-templates '(("d" "default" plain "%?"
     :target (file+head "${slug}.org.gpg"
                        "#+title: ${title}\n")
     :unnarrowed t)))

;; Collapses all sections every time the *org-roam* buffer is updated.
(add-hook 'org-roam-buffer-postrender-functions #'magit-section-show-level-1-all)

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

(require 'org-protocol)

(add-hook! 'elfeed-search-mode-hook 'elfeed-update)

(use-package! lsp-tailwindcss)

(use-package! elcord
  :commands elcord-mode
  :config
  (setq elcord-use-major-mode-as-main-icon t))

(setq default-tab-width 4)
(setq company-minimum-prefix-length 0)
(setq company-idle-delay 0)

(setq flyspell-default-dictionary "english")

(add-hook 'text-mode-hook 'flyspell-mode)

(setq lsp-headerline-breadcrumb-enable t)
