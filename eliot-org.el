(with-eval-after-load 'org-agenda
  (define-key org-agenda-mode-map "e" 'org-agenda-week-view)
  (define-key org-agenda-mode-map "S" 'org-save-all-org-buffers)
  (define-key org-agenda-mode-map "s" 'org-agenda-schedule)
  (define-key org-agenda-mode-map "w" 'org-agenda-refile)
  (define-key org-agenda-mode-map "f" 'org-agenda-set-effort)
  (define-key org-agenda-mode-map "n" 'org-agenda-later)
  (define-key org-agenda-mode-map "p" 'org-agenda-earlier)
  (define-key org-agenda-mode-map "x" 'org-agenda-bulk-mark)
)
(with-eval-after-load 'org


  ;;  (with-eval-after-load 'visual-fill-column
  ;;   (add-hook 'visual-fill-column-mode-hook 'spacemacs/toggle-visual-line-navigation-on)
  ;;   (setq split-window-preferred-function 'visual-fill-column-split-window-sensibly)
  ;;   (advice-add 'text-scale-adjust :after 'visual-fill-column-adjust))

  (setq org-startup-indented t) ; Enable `org-indent-mode' by default
  (add-hook 'org-mode-hook #'visual-line-mode)

  (require 'ox-confluence)

  ;; @ebaker - custom todo keywords
  ;; https://emacs.stackexchange.com/questions/31466/all-todos-how-to-set-different-colors-for-different-categories
  (setq org-todo-keywords
        '(
          (sequence "TODO" "|" "DONE")
          ;; (sequence "TODO" "NEXT" "|" "DONE")
          ))

  ;; @ebaker - TODO does this work or need debugging?
  ;; https://www.computerhope.com/cgi-bin/htmlcolor.pl?c=FF39A3

  (setq org-tag-faces
        '(("TODO" . (:foreground "#ff39a3" :weight bold))
          ("DONE" . (:foreground "#A2FF38" :weight bold))
          ))

  ;; @ebaker - import org-archive-subtree-hierarchical
  ;; https://github.com/ebaker/el/org-archive-subtree-hierarchical.el
  (require 'org-archive-subtree-hierarchical)


  ;; @ebaker - custom bullets
  ;; (setq org-bullets-bullet-list '("◉" "◇" "○" "▻" "⌑"))
  ;; (setq org-bullets-bullet-list '("▣" "▢" "￭" "⌑" "▪" "▫"))
  ;; (setq org-bullets-bullet-list '("▢" "￭" "￮" "●" "▣"))
  ;; (setq org-bullets-bullet-list '("▢" "⬡" "◇" "￮" "▻"))

  ;; @ebaker - folding symbol
  (setq org-ellipsis " v ")
  ;; others - ▼ ▽ ▾ ▿ ﹀ v

  ;; @ebaker - custom cature templates
  ;; TODO - source?
  (setq org-capture-templates
        '(("n" "Notes" entry (file "~/org/capture-emacs.org")
           "* %^{Description} %^g %?
ded: %U")
          ("t" "Todo" entry (file "~/org/capture-emacs.org")
           "* TODO %^{Description} %^g %?
:PROPERTIES:
:CREATED: %U
:END:"))
        )

  ;; @ebaker - org-refile
  ;; @ebaker - TODO source?
  ;; Targets include this file and any file contributing to the agenda - up to 4 levels deep
  ;; (setq org-refile-targets (quote ((nil :maxlevel . 2)
  ;;                                  (org-agenda-files :maxlevel . 2))))
  ;; (setq org-refile-targets (quote ((org-agenda-files :maxlevel . 2))))

  (setq org-refile-targets (quote (
                                   ("~/org/yara.org" :maxlevel . 1)
                                   ("~/org/todo.org" :maxlevel . 1)
                                   ("~/org/notes.org" :maxlevel . 2)
                                   ("~/org/people.org" :maxlevel . 1)
                                   ("~/org/maybe.org" :maxlevel . 1)
                                   ("~/org/emacs.org" :maxlevel . 1)
                                   ("~/org/org.org" :maxlevel . 1)
                                   ("~/org/habits.org" :maxlevel . 1)
                                   ("~/org/computer.org" :maxlevel . 1)
                                   )))

  (setq org-completion-use-ido nil)

  ;; Refile to the Top Level
  (setq org-refile-use-outline-path 'file)
  (setq org-outline-path-complete-in-steps nil)
  (setq org-refile-allow-creating-parent-nodes 'confirm)

  ;; @ebaker agenda commands
  ;; - https://stackoverflow.com/questions/17182954/write-and-call-function-from-agenda-org-mode
  (setq org-agenda-custom-commands
        '(("r" "[r]efile list for captured tasks/notes" tags "+refile")
          ;; match those tagged with :inbox:, are not scheduled, are not DONE.
          ("u" "[u]nscheduled tasks" tags "-refile-SCHEDULED={.+}/!-DONE")
          ("D" "[D]one tasks list" tags "+TODO=\"DONE\"-crypt")
        )
      )

  ;; @ebaker - agenda show five days starting yesterday - https://emacs.stackexchange.com/questions/12517/how-do-i-make-the-timespan-shown-by-org-agenda-start-yesterday
  (setq org-agenda-start-day "-1d")
  (setq org-agenda-span 5)
  (setq org-agenda-start-on-weekday nil)

  ;; @ebaker - TODO update colors
  ;; from http://pragmaticemacs.com/emacs/org-mode-basics-vi-a-simple-todo-list/
  ;; set priority range from A to C with default A
  (setq org-highest-priority ?A)
  (setq org-lowest-priority ?C)
  ;; (setq org-default-priority ?A)

  ;;set colours for priorities
  (setq org-priority-faces '((?A . (:foreground "#FF9538"))
                             (?B . (:foreground "#FFB638"))
                             (?C . (:foreground "#FFD738"))))


  ;; TODO consider a refile & schedule function
  (defun eliot/org-agenda-refile ()
    (interactive)
    (org-agenda-refile))

;; @ebaker - re-map org-meta-return
(org-defkey org-mode-map [(meta return)] 'org-meta-return)

;; org-reveal
;; https://cestlaz.github.io/posts/using-emacs-11-reveal/
;; (use-package ox-reveal
;;   :ensure ox-reveal)
;; (require 'ox-reveal)

(setq org-reveal-root "http://cdn.jsdelivr.net/reveal.js/3.0.0/")
;; (setq org-reveal-mathjax t)

;; (use-package htmlize
;;   :ensure t)
(setq hl-todo-mode nil)

)

;; mermaid
;; (org-babel-do-load-languages 'org-babel-load-languages '((mermaid . t)))

;; plantuml
(org-babel-do-load-languages 'org-babel-load-languages '((plantuml . t)))
(setq org-plantuml-jar-path (expand-file-name "~/Downloads/plantuml.jar"))

;; eliot js - testing
(add-to-list 'auto-mode-alist '("\\.js[x]?$" . web-mode))

;; eliot - mmm-graphql
(require 'graphql-mode)
(require 'mmm-mode)

(mmm-add-classes
 '((js-graphql
    :submode graphql-mode
    :face mmm-declaration-submode-face ;; mmm-code-submode-face
    :front "[^a-zA-Z]gql`" ;; regex to find the opening tag
    :back "`"))) ;; regex to find the closing tag
;; (mmm-add-mode-ext-class 'js2-mode nil 'js-graphql)
(mmm-add-mode-ext-class 'web-mode nil 'js-graphql)

;; eliot - mmm-styled-components
(require 'css-mode)
(require 'mmm-mode)

(mmm-add-classes
 '((js-css
    :submode css-mode
    :face mmm-declaration-submode-face ;; mmm-code-submode-face
    :front "styled\..*`" ;; regex to find the opening tag
    :back "`"))) ;; regex to find the closing tag
;; (mmm-add-mode-ext-class 'js2-mode nil 'js-graphql)
(mmm-add-mode-ext-class 'web-mode nil 'js-css)


(setq mmm-global-mode 'maybe)
;; Optional configuration that hides the background color for a highlighted block
;; I find it useful for debugging emacs, but when actually coding I dont want so much emphasis on submodes
(setq mmm-submode-decoration-level 0)

(provide 'eliot-org)
