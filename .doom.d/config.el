(setq user-full-name "Ivan Trajkov"
      user-mail-address "itrajkov999@gmail.com")

(setq auth-sources '("~/.authinfo.gpg"))

(use-package! pinentry
    :init (setq epg-pinentry-mode `loopback)
    (fset 'epg-wait-for-status 'ignore) ;; Uncertain if there are any side effects.
    (pinentry-start))

(setq doom-font (font-spec :family "Hack Nerd Font" :size 18))

(setq display-line-numbers-type 'relative)
(setq truncate-lines nil)
(setq scroll-margin 9)

(setq doom-theme 'catppuccin)
(setq doom-modeline-height 5)
(set-frame-parameter (selected-frame) 'alpha '(96 . 96))
(add-to-list 'default-frame-alist '(alpha . (96 . 96)))

(after! company
    (setq default-tab-width 4)
    (setq company-minimum-prefix-length 2)
    (setq company-idle-delay 0))

(use-package! lsp-tailwindcss)

(use-package! elcord
  :commands elcord-mode
  :config
  (setq elcord-use-major-mode-as-main-icon t))

(setq org-directory "~/Documents/org")
(setq org-log-done 'time)

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

(setq org-capture-templates `(
    ("p" "Protocol" entry (file+headline ,(concat org-directory "/roam/inbox.org.gpg") "Captured Quotes")
        "* %^{Title}\nSource: %u, %c\n #+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n\n%?")
    ("L" "Protocol Link" entry (file+headline ,(concat org-directory "/roam/inbox.org.gpg") "Captured Links")
        "* %? [[%:link][%:description]] \nCaptured On: %U")
    ("i" "Inbox" entry (file ,(concat org-directory "/roam/inbox.org.gpg"))
        "* %? \n+ Captured on: %T")
    ("t" "Todo" entry (file+headline ,(concat org-directory "/roam/inbox.org.gpg") "Tasks")
        "* TODO %? \n+ Captured on: %T")
))

(defun org-archive-done (&optional arg)
  (org-todo 'done))

(advice-add 'org-archive-subtree :before 'org-archive-done)

(setq org-archive-location (concat org-directory "/roam/archive.org.gpg::* 2022"))

(after! lsp
  (add-hook 'python-mode-hook #'lsp)
    (setq lsp-pylsp-plugins-autopep8-enabled t)
    (setq lsp-pylsp-plugins-flake8-enabled t)
    (setq lsp-pylsp-plugins-pycodestyle-enabled t))

(after! flycheck
  (add-hook 'python-mode-hook
            (lambda ()
              ;; Set Flake8 as the first checker
              (setq-local flycheck-checker 'python-mypy)
              ;; Chain to MyPy after Flake8
              (flycheck-add-next-checker 'python-mypy 'python-flake8))))

(setq dap-python-debugger 'debugpy)
