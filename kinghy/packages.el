;;; packages.el --- kinghy layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author:  rjt <rjt@rjtdeiMac.local>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `kinghy-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `kinghy/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `kinghy/pre-init-PACKAGE' and/or
;;   `kinghy/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst kinghy-packages
  '()
  "The list of Lisp packages required by the kinghy layer.

Each entry is either:

1. A symbol, which is interpreted as a package to be installed, or

2. A list of the form (PACKAGE KEYS...), where PACKAGE is the
    name of the package to be installed or loaded, and KEYS are
    any number of keyword-value-pairs.

    The following keys are accepted:

    - :excluded (t or nil): Prevent the package from being loaded
      if value is non-nil

    - :location: Specify a custom installation location.
      The following values are legal:

      - The symbol `elpa' (default) means PACKAGE will be
        installed using the Emacs package manager.

      - The symbol `local' directs Spacemacs to load the file at
        `./local/PACKAGE/PACKAGE.el'

      - A list beginning with the symbol `recipe' is a melpa
        recipe.  See: https://github.com/milkypostman/melpa#recipe-format")

(with-eval-after-load 'org
  ;; here goes your Org config :)
  ;; ....
  
(defun kinghy/org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-log-states) ; turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))
(add-hook 'org-after-todo-statistics-hook 'kinghy/org-summary-todo)
(setq org-agenda-custom-commands
      '(
        ("w" . "任务安排")
        ("wa" "重要且紧急的任务" tags-todo "+PRIORITY=\"A\"")
        ("wb" "重要且不紧急的任务" tags-todo "-Weekly-Monthly-Daily+PRIORITY=\"B\"")
        ("wc" "不重要且紧急的任务" tags-todo "+PRIORITY=\"C\"")
        ("wd" "不重要且紧急的任务" tags-todo "+PRIORITY=\"D\"")
        ("h" "婚礼" tags-todo "婚礼")
        ;;("p" . "项目安排")
        ;;("pw" tags-todo "PROJECT+WORK+CATEGORY=\"cocos2d-x\"")
        ;;("pl" tags-todo "PROJECT+DREAM+CATEGORY=\"kinghy\"")
        ;;("W" "Weekly Review"
        ;; ((stuck "") ;; review stuck projects as designated by org-stuck-projects
        ;;  (tags-todo "PROJECT") ;; review all projects (assuming you use todo keywords to designate projects)))
        ))
(setq org-todo-keywords
      '(
        (sequence "TODO(t!)" "|" "DONE(d!)" "CANCELED(c@/!)" "RESET(r!)" )
        ))    
(setq org-agenda-files (list "~/Coding/org/gtd" "~/Coding/org/doc" "~/Coding/org/note"))

(setq org-default-notes-file "~/Coding/org/gtd/inbox.org")

      ;;add multi-file journal
      (setq org-capture-templates
            '(("i" "Inbox" entry (file+headline "~/Coding/org/gtd/inbox.org" "Inbox")
               "** [#B] %?\n  %i\n"
               :empty-lines 1)
              ("t" "Task" entry (file+headline "~/Coding/org/gtd/task.org" "常规任务")
               "** TODO [#B] %?\n  %i\n"
               :empty-lines 1)
              ("p" "项目" entry (file+headline "~/Coding/org/gtd/project.org" "项目任务")
               "** TODO [#B] %?\n  %i\n"
               :empty-lines 1)

              ("w" "婚礼" entry (file+headline "~/Coding/org/gtd/task.org" "婚礼任务")
               "** TODO [#B] %?\n  %i\n"
               :empty-lines 1)

              ("n" "notes" entry (file+headline "~/Coding/org/note/note.org" "Quick notes")
               "* %?\n  %i\n %U"
               :empty-lines 1)
              ("s" "Code Snippet" entry
               (file "~/Coding/org/note/snippets.org")
               "* %?\t%^g\n#+BEGIN_SRC %^{language}\n\n#+END_SRC")
              ;;("w" "work" entry (file+headline "~/Coding/org/gtd/gtd.org" "Cocos2D-X")
              ;; "* TODO [#A] %?\n  %i\n %U"
              ;; :empty-lines 1)
              ("c" "Chrome" entry (file+headline "~/Coding/org/note/note.org" "Quick notes")
               "* TODO [#C] %?\n %(kinghy/retrieve-chrome-current-tab-url)\n %i\n %U"
               :empty-lines 1)
              ("l" "links" entry (file+headline "~/Coding/org/note/note.org" "Quick notes")
               "* TODO [#C] %?\n  %i\n %a \n %U"
               :empty-lines 1)
              ))

(setq org-tag-alist '(

;;(:startgroup . nil)
;;("桌面" . ?d) ("服务器" . ?s)
;;(:endgroup . nil)
;;("编辑器" . ?e)
;;("浏览器" . ?f)
;;("多媒体" . ?m)
                      ("锻炼" . ?t)
                      ("婚礼" . ?h)
                      ))

;; 将项目转接在各文件之间，方便清理和回顾。
(custom-set-variables
 '(org-refile-targets
   (quote
    (("inbox.org" :level . 1)("finished.org":level . 1) ("task.org":level . 1) ("project.org":level . 1) ("trash.org":level . 1))
    )))
;; 快速打开inbox
(defun inbox() (interactive) (find-file "~/Coding/org/gtd/inbox.org"))
;;; packages.el ends here
(setq org-bullets-bullet-list '("♥" "◆" "♠" "♣"))
;;♥ ● ◇ ✚ ✜  ♦ ☢ ❀ ◆ ◖ ▶
  )
 
;;set transparent effect

(global-set-key [(f12)] 'loop-alpha)
(setq alpha-list '((0 0) (100 100))) 
(defun loop-alpha ()
(interactive)
(let ((h (car alpha-list)))                ;; head value will set to
      ((lambda (a ab)
               (set-frame-parameter (selected-frame) 'alpha (list a ab))
               (add-to-list 'default-frame-alist (cons 'alpha (list a ab)))
               ) (car h) (car (cdr h)))
      (setq alpha-list (cdr (append alpha-list (list h))))
      )
)


;;开机自动显示日程表
;;(org-agenda-list t)
;;关闭其它窗口
;;(delete-other-windows)

;;(eval-after-load 'org-agenda
;;  (progn
;;    (message "1234")
;;    (org-agenda-list t)))

(split-window-vertically)
(other-window 1)
(shell)
(other-window 0)

(defun kinghy/insert-chrome-current-tab-url()
  "Get the URL of the active tab of the first window"
  (interactive)
  (insert (kinghy/retrieve-chrome-current-tab-url)))

(defun kinghy/retrieve-chrome-current-tab-url()
  "Get the URL of the active tab of the first window"
  (interactive)

  (let ((link (do-applescript
                 (concat
                  "set frontmostApplication to path to frontmost application\n"
                  "tell application \"Google Chrome\"\n"
                  "	set theUrl to get URL of active tab of first window\n"
                  "	set theResult to (get theUrl) \n"
                  "end tell\n"
                  "activate application (frontmostApplication as text)\n"
                  "set links to {}\n"
                  "copy theResult to the end of links\n"
                  "return links as string\n")))
        (title (do-applescript
                  (concat
                   "set frontmostApplication to path to frontmost application\n"
                   "tell application \"Google Chrome\"\n"
                   "	set theUrl to get title of active tab of first window\n"
                   "	set theResult to (get theUrl) \n"
                   "end tell\n"
                   "activate application (frontmostApplication as text)\n"
                   "return theResult as string\n")))
        ) (let (
                (result-link (read-from-minibuffer "Checkout Link From Chrome:" link))
                (result-title (read-from-minibuffer "Checkout Title From Chrome:" title)))
            (format "[[%s][%s]]" (s-chop-suffix "\"" (s-chop-prefix "\"" result-link)) result-title))))

(global-set-key "\C-cku" 'kinghy/insert-chrome-current-tab-url)



;(switch-to-buffer-other-window "*test*")
 ;(progn
;  (switch-to-buffer-other-window "*test2*")
;  (shell))

;; 快速打开配置文件
(defun open-packages-file()
  (interactive)
  (find-file "~/.emacs.d/private/kinghy/packages.el"))

(global-set-key "\C-ckp" 'open-packages-file)
