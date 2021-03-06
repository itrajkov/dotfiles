(setq user-full-name "Ivan Trajkov"
      user-mail-address "itrajkov999@gmail.com")

(defun greedily-do-daemon-setup ()
  (require 'org)
  (when (require 'mu4e nil t)
    (setq mu4e-confirm-quit t)
    (setq +mu4e-lock-greedy t)
    (setq +mu4e-lock-relaxed t)
    (mu4e~start)))

(when (daemonp)
  (add-hook 'emacs-startup-hook #'greedily-do-daemon-setup)
  (add-hook! 'server-after-make-frame-hook
    (unless (string-match-p "\\*draft" (buffer-name)))))

(setq auth-sources '("~/.authinfo.gpg"))

(map! :map evil-motion-state-map "C-u" #'my/evil-scroll-up-and-center)
(map! :map evil-motion-state-map "C-d" #'my/evil-scroll-down-and-center)
(map! :map evil-normal-state-map "C-x" #'evil-numbers/dec-at-pt-incremental)
(map! :map evil-normal-state-map "C-a" #'evil-numbers/inc-at-pt-incremental)
(map! :map evil-normal-state-map "C--" #'doom/decrease-font-size)
(map! :map evil-normal-state-map "C-+" #'doom/increase-font-size)

(map! :leader
      :desc "Start ERC"
      "o i" #'my/erc-start-or-switch
      "i i" #'erc-switch-to-buffer)

;;(map! :map specific-mode-map :n "J" (cmd! (a-function) (b-function)))

(map! :map erc-mode-map :n "J" #'erc-join-channel)
(map! :map erc-mode-map :n "qq" #'my/erc-stop)
(map! :map erc-mode-map :n "c u" #'my/erc-count-users)

(setq doom-font (font-spec :family "Fira Code Nerd Font" :size 18))

(setq display-line-numbers-type 'relative)
(setq truncate-lines nil)
(setq scroll-margin 9)

(setq doom-theme 'doom-snazzy)
;; (set-frame-parameter (selected-frame) 'alpha '(97 . 97))
;; (add-to-list 'default-frame-alist '(alpha . (97 . 97)))
(setq doom-modeline-height 5)

(set-email-account! "All"
  '((user-mail-address . "ivchepro@gmail.com")
    (user-full-name    . "Беден Буџи")
    (smtpmail-smtp-server . "smtp.gmail.com")
    (smtpmail-smtp-service . 465)
    (smtpmail-stream-type . ssl)
    (smtpmail-smtp-user . "ivchepro@gmail.com")
    (mu4e-drafts-folder  . "/ivchepro/[Gmail]/Drafts")
    (mu4e-sent-folder  . "/ivchepro/[Gmail]/Sent Mail")
    (mu4e-refile-folder  . "/ivchepro/[Gmail]/All Mail")
    (mu4e-trash-folder  . "/ivchepro/[Gmail]/Trash")
    (smtpmail-queue-dir .  "~/Mail/ivchepro/queue/cur")
    (mu4e-compose-signature . "---\nYours truly\nIvche.")
    (mu4e-maildir-shortcuts .
        (("/ivchepro/Inbox"             . ?i)
        ("/ivchepro/[Gmail]/Sent Mail" . ?s)
        ("/ivchepro/[Gmail]/Trash"     . ?t)
        ("/ivchepro/[Gmail]/Drafts"    . ?d)
        ("/ivchepro/[Gmail]/All Mail"  . ?a))))
  t)

(set-email-account! "Main"
  '((user-mail-address . "itrajkov999@gmail.com")
    (user-full-name    . "Ivan Trajkov")
    (smtpmail-smtp-server . "smtp.gmail.com")
    (smtpmail-smtp-service . 465)
    (smtpmail-stream-type . ssl)
    (smtpmail-smtp-user . "itrajkov999@gmail.com")
    (mu4e-drafts-folder  . "/itrajkov999/[Gmail]/Drafts")
    (mu4e-sent-folder  . "/itrajkov999/[Gmail]/Sent Mail")
    (mu4e-refile-folder  . "/itrajkov999/[Gmail]/All Mail")
    (mu4e-trash-folder  . "/itrajkov999/[Gmail]/Trash")
    (smtpmail-queue-dir .  "~/Mail/itrajkov999/queue/cur")
    (mu4e-compose-signature . "---\nYours truly\nIvan.")
    (mu4e-maildir-shortcuts .
        (("/itrajkov999/Inbox"             . ?i)
        ("/itrajkov999/[Gmail]/Sent Mail" . ?s)
        ("/itrajkov999/[Gmail]/Trash"     . ?t)
        ("/itrajkov999/[Gmail]/Drafts"    . ?d)
        ("/itrajkov999/[Gmail]/All Mail"  . ?a))))
  t)

(setq smtpmail-queue-mail t)  ;; start in queuing mode
(after! mu4e (setq mu4e-update-interval 60))

(setq mu4e-context-policy 'ask-if-none
      mu4e-compose-context-policy 'always-ask)

;; don't need to run cleanup after indexing for gmail
(setq mu4e-index-cleanup nil
      ;; because gmail uses labels as folders we can use lazy check since
      ;; messages don't really "move"
      mu4e-index-lazy-check t)

(setq mu4e-alert-icon "/usr/share/icons/Papirus/64x64/apps/evolution.svg")

(setq mu4e-headers-fields
      '((:flags . 6)
        (:account-stripe . 2)
        (:from-or-to . 25)
        (:folder . 10)
        (:recipnum . 2)
        (:subject . 80)
        (:human-date . 8))
      +mu4e-min-header-frame-width 142
      mu4e-headers-date-format "%d/%m/%y"
      mu4e-headers-time-format "⧖ %H:%M"
      mu4e-headers-results-limit 1000
      mu4e-index-cleanup t)

(require 'erc-log)
(require 'erc-notify)
(require 'erc-nick-notify)
(require 'erc-spelling)
(require 'erc-autoaway)


(use-package erc
  :commands erc erc-tls
  :config
    ;; Join the a couple of interesting channels whenever connecting to Freenode.
    (setq erc-autojoin-channels-alist '(("myanonamouse.net"
                                        "#am-members")
                                        ("libera.chat"
                                        "#spodeli")))

    (add-hook 'window-configuration-change-hook
        '(lambda ()
            (setq erc-fill-column (- (window-width) 2))))

    ;; Interpret mIRC-style color commands in IRC chats
    (setq erc-interpret-mirc-color t)

    ;; The following are commented out by default, but users of other
    ;; non-Emacs IRC clients might find them useful.
    ;; Kill buffers for channels after /part
    (setq erc-kill-buffer-on-part t)
    ;; Kill buffers for private queries after quitting the server
    (setq erc-kill-queries-on-quit t)
    ;; Kill buffers for server messages after quitting the server
    (setq erc-kill-server-buffer-on-quit t)

    ;; open query buffers in the current window
    (setq erc-query-display 'buffer)

    (setq erc-track-shorten-function nil)
    ;; exclude boring stuff from tracking
    (erc-track-mode t)
    (setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE"
                                    "324" "329" "332" "333" "353" "477"))

    ;; truncate long irc buffers
    (erc-truncate-mode +1)

    ;; reconnecting
    (setq erc-server-reconnect-attempts 5)
    (setq erc-server-reconnect-timeout 30)

    ;; share my real name
    (setq erc-user-full-name "Ivan Trajkov")

    ;; enable spell checking
    (erc-spelling-mode 1)

    (defvar erc-notify-timeout 10
    "Number of seconds that must elapse between notifications from
    the same person.")

    (defun my/erc-notify (nickname message)
    "Displays a notification message for ERC."
    (let* ((channel (buffer-name))
            (nick (erc-hl-nicks-trim-irc-nick nickname))
            (title (if (string-match-p (concat "^" nickname) channel)
                        nick
                    (concat nick " (" channel ")")))
            (msg (s-trim (s-collapse-whitespace message))))
        (alert (concat nick ": " msg) :title title)))

    ;; autoaway setup
    (setq erc-auto-discard-away t)
    (setq erc-autoaway-idle-seconds 600)
    (setq erc-autoaway-use-emacs-idle t)
    (setq erc-prompt-for-nickserv-password nil)

    ;; utf-8 always and forever
    (setq erc-server-coding-system '(utf-8 . utf-8))

    (defun my/erc-start-or-switch ()
    "Connects to ERC, or switch to last active buffer."
    (interactive)
    (if (get-buffer "irc.libera.chat:6697")
        (erc-track-switch-buffer 1)
        (when (y-or-n-p "Start ERC? ")
        (erc-tls :server "irc.libera.chat" :port 6697 :nick "ivche")
        (erc-tls :server "irc.myanonamouse.net" :port 6697 :nick "Ivche1337")
        )))

    (defun my/erc-count-users ()
    "Displays the number of users connected on the current channel."
    (interactive)
    (if (get-buffer "irc.libera.chat:6697")
        (let ((channel (erc-default-target)))
            (if (and channel (erc-channel-p channel))
                (message "%d users are online on %s"
                        (hash-table-count erc-channel-users)
                        channel)
            (user-error "The current buffer is not a channel")))
        (user-error "You must first start ERC")))

    (defun filter-server-buffers ()
    (delq nil
            (mapcar
            (lambda (x) (and (erc-server-buffer-p x) x))
            (buffer-list))))

    (defun my/erc-stop ()
    "Disconnects from all irc servers"
    (interactive)
    (dolist (buffer (filter-server-buffers))
        (message "Server buffer: %s" (buffer-name buffer))
        (with-current-buffer buffer
        (erc-quit-server "cya nerds! - sent from ERC"))))
)

(use-package erc-hl-nicks
  :after erc)

(setq default-tab-width 4)
(setq company-minimum-prefix-length 2)
(setq company-idle-delay 0)

(setq org-directory "~/Dropbox/org")
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

  (with-eval-after-load 'org
    (setq org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)" "REVIEW(r)" "ARCHIVED(a)"))))

(add-to-list 'org-modules 'org-habit t)

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

(setq org-super-agenda-header-map (make-sparse-keymap))
(use-package! org-super-agenda
  :after org-agenda
  :custom-face
  (org-super-agenda-header ((default (:inherit propositum-agenda-heading))))

  :init
  (setq org-agenda-skip-scheduled-if-done t
        org-agenda-file-regexp "\\`[^.].*\\.org.gpg\\'"
        org-agenda-files `(,(concat org-directory "/roam"))
        org-agenda-skip-deadline-if-done t
        org-agenda-include-deadlines t
        org-agenda-block-separator nil
        org-agenda-compact-blocks t
        org-agenda-start-day nil ;; i.e. today
        org-agenda-span 1
        org-agenda-start-on-weekday nil)
  (setq org-agenda-custom-commands
        '(("p" "Project view"
           ((alltodo "" ((org-agenda-overriding-header "Project Tasks"))))
           ((org-agenda-tag-filter-preset '("+project"))))
          ("i" "Inbox view"
           ((alltodo "" ((org-agenda-overriding-header "Inbox"))))
           ((org-agenda-tag-filter-preset '("+inbox"))))
          ("n" "Next actions"
           ((alltodo "" ((org-agenda-overriding-header "Inbox"))))
           ((org-agenda-tag-filter-preset '("+next"))))
          ("w" todo "WAITING"
           ((alltodo "")))))

  :config
  (org-super-agenda-mode))

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

(use-package! org-wild-notifier
  :custom
  (alert-default-style 'notifications)
  (org-wild-notifier-alert-time '(5 10 30 60 120))
  (org-wild-notifier-keyword-whitelist nil)
  (org-wild-notifier-notification-title "Task reminder!")
  :config
  (org-wild-notifier-mode 1))

(add-hook! 'elfeed-search-mode-hook 'elfeed-update)

(use-package! tree-sitter
  :config
  (require 'tree-sitter-langs)
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))
