;;; magik-menu.el --- set the Magik menus.  -*- lexical-binding: t; -*-

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;;

;;; Code:

(require 'magik-aliases)
(require 'magik-version)
(require 'magik-mode)
(require 'magik-session)
(require 'magik-session-filter)
(require 'magik-cb)

(require 'easymenu)

(defconst magik-menu-main-menu
  `(,"Magik"
    (,"Alias Files")
    "---"
    [,"Select Environment" magik-version-selection          t]
    [,"Run/Goto session"   magik-session                    t]
    [,"Start new session"  magik-session-new-buffer :active t :keys "C-u <f2> z"]
    (,"Magik Session Processes")
    "---"
    (,"Class Browser")
    (,"Class Browser Processes")
    "---"
    (,"External Shell Processes")
    [,"List Processes"    list-processes  t]
    "---"
    [,"Customize"         magik-customize t]
    (,"Help")))

(defconst magik-menu-cb-menu
  `(,"Class Browser"
    [,"Run/Goto Class Browser"       magik-cb                      t]
    [,"Start New Class Browser"      magik-cb-new-buffer   :active t :keys "C-u <f3> <f3>"]
    [,"Paste Method in CB"           magik-cb-paste-method         t]
    [,"Paste Class in CB"            magik-cb-paste-class          t]
    [,"Clear Method and Class in CB" magik-cb-and-clear            t]
    "---"
    [,"Jump to Source"               magik-cb-jump-to-source t]
    "---"
    [,"Customize"                    magik-cb-customize      t]
    ;; [,"Help"                         magik-cb-help
    ;;  :active t
    ;;  :keys "<f3> ?"]
    ))

;;;###autoload
(defun magik-menu-set-menus ()
  "Setup main Magik menus."
  (easy-menu-change (list "Tools")
                    "Magik"
                    (cdr magik-menu-main-menu)
                    "Search Files (Grep)...")
  (easy-menu-change (list "Tools" "Magik")
                    "Class Browser"
                    (cdr magik-menu-cb-menu))

  ;; Due to a minor bug in easy-menu-change, have to set the "No Process" etc.
  ;; strings separately
  (easy-menu-change (list "Tools" "Magik")
                    "Magik Session Processes"
                    (list "No Processes"))
  (easy-menu-change (list "Tools" "Magik")
                    "Class Browser Processes"
                    (list "No Processes"))
  (easy-menu-change (list "Tools" "Magik")
                    "External Shell Processes"
                    (list "No Processes"))

  (easy-menu-change (list "Tools") "--" nil "Search Files (Grep)...")

  (and (fboundp 'magik-aliases-update-sw-menu)
       (magik-aliases-update-sw-menu)))

(provide 'magik-menu)
;;; magik-menu.el ends here
