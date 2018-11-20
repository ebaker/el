(with-eval-after-load 'org

  ;; @ebaker - custom todo keywords
  ;; https://emacs.stackexchange.com/questions/31466/all-todos-how-to-set-different-colors-for-different-categories
  (setq org-todo-keywords
        '(
          (sequence "TODO" "NEXT" "|" "DONE")
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
  (setq org-bullets-bullet-list '("◉" "◇" "○" "▻" "⌑"))
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
  (setq org-refile-targets (quote ((nil :maxlevel . 2)
                                   (org-agenda-files :maxlevel . 2))))
  (setq org-completion-use-ido nil)
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

  ;; @ebaker - TODO update colors
  ;; from http://pragmaticemacs.com/emacs/org-mode-basics-vi-a-simple-todo-list/
  ;; set priority range from A to C with default A
  (setq org-highest-priority ?A)
  (setq org-lowest-priority ?C)
  ;; (setq org-default-priority ?A)

  ;;set colours for priorities
  (setq org-priority-faces '((?A . (:foreground "#F0DFAF" :weight bold))
                             (?B . (:foreground "LightSteelBlue"))
                             (?C . (:foreground "OliveDrab"))))


  ;; TODO consider a refile & schedule function
  (defun eliot/org-agenda-refile ()
    (interactive)
    (org-agenda-refile))

;; @ebaker - re-map org-meta-return
(org-defkey org-mode-map [(meta return)] 'org-meta-return)

)

(provide 'eliot-org)
