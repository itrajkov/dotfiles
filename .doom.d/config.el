(setq user-full-name "Ivche"
      user-mail-address "itrajkov999@gmail.com")

(map! :leader
      :desc "Start ERC"
      "o i" #'my/erc-start-or-switch
      "i i" #'erc-switch-to-buffer)

;;(map! :map specific-mode-map :n "J" (cmd! (a-function) (b-function)))

(map! :map erc-mode-map :n "J" #'erc-join-channel)
(map! :map erc-mode-map :n "qq" #'my/erc-stop)
(map! :map erc-mode-map :n "c u" #'my/erc-count-users)

(setq auth-sources '("~/.authinfo.gpg"))

(setq initial-scratch-message ";; Happy Hacking!\n")

(setq doom-font (font-spec :family "FiraCode Nerd Font" :size 18))

(setq display-line-numbers-type 'relative)
(setq truncate-lines nil)
(setq scroll-margin 9)

(setq doom-theme 'doom-acario-dark)
(setq doom-modeline-height 4)
;; (set-frame-parameter (selected-frame) 'alpha '(96 . 96))
;; (add-to-list 'default-frame-alist '(alpha . (96 . 96)))

(set-email-account! "Main"
  '((user-mail-address . "ivche@trajkov.mk")
    (user-full-name    . "Ivche")
    (smtpmail-smtp-server . "smtp.gmail.com")
    (smtpmail-smtp-service . 465)
    (smtpmail-stream-type . ssl)
    (smtpmail-smtp-user . "ivche@trajkov.mk")
    (mu4e-drafts-folder  . "/ivche/Drafts")
    (mu4e-sent-folder  . "/ivche/Sent Mail")
    (mu4e-refile-folder  . "/ivche/All Mail")
    (mu4e-trash-folder  . "/ivche/Trash")
    (smtpmail-queue-dir .  "~/Mail/ivche/queue/cur")
    (mu4e-compose-signature . "---\nYours truly\nIvche.")
    (mu4e-maildir-shortcuts .
        (("/ivche/Inbox"             . ?i)
        ("/ivche/Sent Mail" . ?s)
        ("/ivche/Trash"     . ?t)
        ("/ivche/Drafts"    . ?d)
        ("/ivche/All Mail"  . ?a))))
  t)

(set-email-account! "Professional"
  '((user-mail-address . "ivan@trajkov.mk")
    (user-full-name    . "Ivan Trajkov")
    (smtpmail-smtp-server . "mail.trajkov.mk")
    (smtpmail-smtp-service . 465)
    (smtpmail-stream-type . ssl)
    (smtpmail-smtp-user . "ivan@trajkov.mk")
    (mu4e-drafts-folder  . "/ivan/[Gmail]/Drafts")
    (mu4e-sent-folder  . "/ivan/[Gmail]/Sent Mail")
    (mu4e-refile-folder  . "/ivan/[Gmail]/All Mail")
    (mu4e-trash-folder  . "/ivan/[Gmail]/Trash")
    (smtpmail-queue-dir .  "~/Mail/ivan/queue/cur")
    (mu4e-compose-signature . "---\nYours truly\nIvan.")
    (mu4e-maildir-shortcuts .
        (("/ivan/Inbox"             . ?i)
        ("/ivan/Sent Mail" . ?s)
        ("/ivan/Trash"     . ?t)
        ("/ivan/Drafts"    . ?d)
        ("/ivan/All Mail"  . ?a))))
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

;; (setq mu4e-alert-icon "/usr/share/icons/Adwaita/16x16/status/mail-unread-symbolic.symbolic.png")

(setq mu4e-headers-fields
      '((:flags . 6)
        (:account-stripe . 2)
        (:from-or-to . 25)
        (:recipnum . 2)
        (:subject . 80)
        (:human-date . 8))
      +mu4e-min-header-frame-width 142
      mu4e-headers-date-format "%d/%m/%y"
      mu4e-headers-time-format "⧖ %H:%M"
      mu4e-headers-results-limit 1000
      mu4e-index-cleanup t)

(mu4e t)

(require 'erc-log)
(require 'erc-notify)
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
    (setq erc-user-full-name "Ivche")

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

(after! company
    (setq default-tab-width 4)
    (setq company-minimum-prefix-length 3)
    (setq company-idle-delay 0.3))

(use-package! elcord
  :commands elcord-mode
  :config
  (setq elcord-use-major-mode-as-main-icon t))

(setq lsp-headerline-breadcrumb-enable t)

(after! leetcode
    (setq leetcode-prefer-language "python3")
    (setq leetcode-save-solutions t)
    (setq leetcode-directory "~/Dev/leetcode"))

(after! flycheck
  (add-hook 'python-mode-hook
            (lambda ()
              (setq-local flycheck-checker 'python-mypy)
              (setq flycheck-checker-error-threshold 3000))))

(after! dap-mode
  (setq dap-python-debugger 'debugpy))

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
