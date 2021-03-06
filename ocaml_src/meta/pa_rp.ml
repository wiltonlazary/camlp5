(* camlp5r *)
(* pa_rp.ml,v *)
(* Copyright (c) INRIA 2007-2017 *)

(* #load "pa_extend.cmo" *)
(* #load "q_MLast.cmo" *)

open Exparser;;
open Pcaml;;

(* Syntax extensions in Revised Syntax grammar *)

Grammar.extend
  (let _ = (expr : 'expr Grammar.Entry.e)
   and _ = (ipatt : 'ipatt Grammar.Entry.e) in
   let grammar_entry_create s =
     Grammar.create_local_entry (Grammar.of_entry expr) s
   in
   let parser_case : 'parser_case Grammar.Entry.e =
     grammar_entry_create "parser_case"
   and stream_patt : 'stream_patt Grammar.Entry.e =
     grammar_entry_create "stream_patt"
   and stream_patt_kont : 'stream_patt_kont Grammar.Entry.e =
     grammar_entry_create "stream_patt_kont"
   and stream_patt_comp_err : 'stream_patt_comp_err Grammar.Entry.e =
     grammar_entry_create "stream_patt_comp_err"
   and stream_patt_comp : 'stream_patt_comp Grammar.Entry.e =
     grammar_entry_create "stream_patt_comp"
   and stream_patt_let : 'stream_patt_let Grammar.Entry.e =
     grammar_entry_create "stream_patt_let"
   and lookahead : 'lookahead Grammar.Entry.e =
     grammar_entry_create "lookahead"
   and stream_expr_comp : 'stream_expr_comp Grammar.Entry.e =
     grammar_entry_create "stream_expr_comp"
   in
   [Grammar.Entry.obj (expr : 'expr Grammar.Entry.e),
    Some (Gramext.Level "top"),
    [None, None,
     [[Gramext.Stoken ("", "match"); Gramext.Sself;
       Gramext.Stoken ("", "with"); Gramext.Stoken ("", "parser");
       Gramext.Sopt
         (Gramext.Snterm
            (Grammar.Entry.obj (ipatt : 'ipatt Grammar.Entry.e)));
       Gramext.Snterm
         (Grammar.Entry.obj (parser_case : 'parser_case Grammar.Entry.e))],
      Gramext.action
        (fun (pc : 'parser_case) (po : 'ipatt option) _ _ (e : 'expr) _
             (loc : Ploc.t) ->
           (cparser_match loc e po [pc] : 'expr));
      [Gramext.Stoken ("", "match"); Gramext.Sself;
       Gramext.Stoken ("", "with"); Gramext.Stoken ("", "parser");
       Gramext.Sopt
         (Gramext.Snterm
            (Grammar.Entry.obj (ipatt : 'ipatt Grammar.Entry.e)));
       Gramext.Stoken ("", "[");
       Gramext.Slist0sep
         (Gramext.Snterm
            (Grammar.Entry.obj (parser_case : 'parser_case Grammar.Entry.e)),
          Gramext.Stoken ("", "|"), false);
       Gramext.Stoken ("", "]")],
      Gramext.action
        (fun _ (pcl : 'parser_case list) _ (po : 'ipatt option) _ _
             (e : 'expr) _ (loc : Ploc.t) ->
           (cparser_match loc e po pcl : 'expr));
      [Gramext.Stoken ("", "parser");
       Gramext.Sopt
         (Gramext.Snterm
            (Grammar.Entry.obj (ipatt : 'ipatt Grammar.Entry.e)));
       Gramext.Snterm
         (Grammar.Entry.obj (parser_case : 'parser_case Grammar.Entry.e))],
      Gramext.action
        (fun (pc : 'parser_case) (po : 'ipatt option) _ (loc : Ploc.t) ->
           (cparser loc po [pc] : 'expr));
      [Gramext.Stoken ("", "parser");
       Gramext.Sopt
         (Gramext.Snterm
            (Grammar.Entry.obj (ipatt : 'ipatt Grammar.Entry.e)));
       Gramext.Stoken ("", "[");
       Gramext.Slist0sep
         (Gramext.Snterm
            (Grammar.Entry.obj (parser_case : 'parser_case Grammar.Entry.e)),
          Gramext.Stoken ("", "|"), false);
       Gramext.Stoken ("", "]")],
      Gramext.action
        (fun _ (pcl : 'parser_case list) _ (po : 'ipatt option) _
             (loc : Ploc.t) ->
           (cparser loc po pcl : 'expr))]];
    Grammar.Entry.obj (parser_case : 'parser_case Grammar.Entry.e), None,
    [None, None,
     [[Gramext.Stoken ("", "[:");
       Gramext.Snterm
         (Grammar.Entry.obj (stream_patt : 'stream_patt Grammar.Entry.e));
       Gramext.Stoken ("", ":]");
       Gramext.Sopt
         (Gramext.Snterm
            (Grammar.Entry.obj (ipatt : 'ipatt Grammar.Entry.e)));
       Gramext.Stoken ("", "->");
       Gramext.Snterm (Grammar.Entry.obj (expr : 'expr Grammar.Entry.e))],
      Gramext.action
        (fun (e : 'expr) _ (po : 'ipatt option) _ (sp : 'stream_patt) _
             (loc : Ploc.t) ->
           (sp, po, e : 'parser_case))]];
    Grammar.Entry.obj (stream_patt : 'stream_patt Grammar.Entry.e), None,
    [None, None,
     [[], Gramext.action (fun (loc : Ploc.t) -> ([] : 'stream_patt));
      [Gramext.Snterm
         (Grammar.Entry.obj
            (stream_patt_let : 'stream_patt_let Grammar.Entry.e));
       Gramext.Sself],
      Gramext.action
        (fun (sp : 'stream_patt) (spc : 'stream_patt_let) (loc : Ploc.t) ->
           (spc :: sp : 'stream_patt));
      [Gramext.Snterm
         (Grammar.Entry.obj
            (stream_patt_comp : 'stream_patt_comp Grammar.Entry.e));
       Gramext.Stoken ("", ";");
       Gramext.Snterm
         (Grammar.Entry.obj
            (stream_patt_kont : 'stream_patt_kont Grammar.Entry.e))],
      Gramext.action
        (fun (sp : 'stream_patt_kont) _ (spc : 'stream_patt_comp)
             (loc : Ploc.t) ->
           ((spc, SpoNoth) :: sp : 'stream_patt));
      [Gramext.Snterm
         (Grammar.Entry.obj
            (stream_patt_comp : 'stream_patt_comp Grammar.Entry.e))],
      Gramext.action
        (fun (spc : 'stream_patt_comp) (loc : Ploc.t) ->
           ([spc, SpoNoth] : 'stream_patt))]];
    Grammar.Entry.obj (stream_patt_kont : 'stream_patt_kont Grammar.Entry.e),
    None,
    [None, None,
     [[Gramext.Snterm
         (Grammar.Entry.obj
            (stream_patt_let : 'stream_patt_let Grammar.Entry.e));
       Gramext.Sself],
      Gramext.action
        (fun (sp : 'stream_patt_kont) (spc : 'stream_patt_let)
             (loc : Ploc.t) ->
           (spc :: sp : 'stream_patt_kont));
      [Gramext.Snterm
         (Grammar.Entry.obj
            (stream_patt_comp_err : 'stream_patt_comp_err Grammar.Entry.e));
       Gramext.Stoken ("", ";"); Gramext.Sself],
      Gramext.action
        (fun (sp : 'stream_patt_kont) _ (spc : 'stream_patt_comp_err)
             (loc : Ploc.t) ->
           (spc :: sp : 'stream_patt_kont));
      [Gramext.Snterm
         (Grammar.Entry.obj
            (stream_patt_comp_err : 'stream_patt_comp_err Grammar.Entry.e))],
      Gramext.action
        (fun (spc : 'stream_patt_comp_err) (loc : Ploc.t) ->
           ([spc] : 'stream_patt_kont))]];
    Grammar.Entry.obj
      (stream_patt_comp_err : 'stream_patt_comp_err Grammar.Entry.e),
    None,
    [None, None,
     [[Gramext.Snterm
         (Grammar.Entry.obj
            (stream_patt_comp : 'stream_patt_comp Grammar.Entry.e))],
      Gramext.action
        (fun (spc : 'stream_patt_comp) (loc : Ploc.t) ->
           (spc, SpoNoth : 'stream_patt_comp_err));
      [Gramext.Snterm
         (Grammar.Entry.obj
            (stream_patt_comp : 'stream_patt_comp Grammar.Entry.e));
       Gramext.Stoken ("", "!")],
      Gramext.action
        (fun _ (spc : 'stream_patt_comp) (loc : Ploc.t) ->
           (spc, SpoBang : 'stream_patt_comp_err));
      [Gramext.Snterm
         (Grammar.Entry.obj
            (stream_patt_comp : 'stream_patt_comp Grammar.Entry.e));
       Gramext.Stoken ("", "?");
       Gramext.Snterm (Grammar.Entry.obj (expr : 'expr Grammar.Entry.e))],
      Gramext.action
        (fun (e : 'expr) _ (spc : 'stream_patt_comp) (loc : Ploc.t) ->
           (spc, SpoQues e : 'stream_patt_comp_err))]];
    Grammar.Entry.obj (stream_patt_comp : 'stream_patt_comp Grammar.Entry.e),
    None,
    [None, None,
     [[Gramext.Snterm (Grammar.Entry.obj (patt : 'patt Grammar.Entry.e))],
      Gramext.action
        (fun (p : 'patt) (loc : Ploc.t) ->
           (SpStr (loc, p) : 'stream_patt_comp));
      [Gramext.Snterm (Grammar.Entry.obj (patt : 'patt Grammar.Entry.e));
       Gramext.Stoken ("", "=");
       Gramext.Snterm (Grammar.Entry.obj (expr : 'expr Grammar.Entry.e))],
      Gramext.action
        (fun (e : 'expr) _ (p : 'patt) (loc : Ploc.t) ->
           (SpNtr (loc, p, e) : 'stream_patt_comp));
      [Gramext.Stoken ("", "?=");
       Gramext.Slist1sep
         (Gramext.Snterm
            (Grammar.Entry.obj (lookahead : 'lookahead Grammar.Entry.e)),
          Gramext.Stoken ("", "|"), false)],
      Gramext.action
        (fun (pll : 'lookahead list) _ (loc : Ploc.t) ->
           (SpLhd (loc, pll) : 'stream_patt_comp));
      [Gramext.Stoken ("", "`");
       Gramext.Snterm (Grammar.Entry.obj (patt : 'patt Grammar.Entry.e));
       Gramext.Sopt
         (Gramext.srules
            [[Gramext.Stoken ("", "when");
              Gramext.Snterm
                (Grammar.Entry.obj (expr : 'expr Grammar.Entry.e))],
             Gramext.action
               (fun (e : 'expr) _ (loc : Ploc.t) -> (e : 'e__1))])],
      Gramext.action
        (fun (eo : 'e__1 option) (p : 'patt) _ (loc : Ploc.t) ->
           (SpTrm (loc, p, eo) : 'stream_patt_comp))]];
    Grammar.Entry.obj (stream_patt_let : 'stream_patt_let Grammar.Entry.e),
    None,
    [None, None,
     [[Gramext.Stoken ("", "let");
       Gramext.Snterm (Grammar.Entry.obj (ipatt : 'ipatt Grammar.Entry.e));
       Gramext.Stoken ("", "=");
       Gramext.Snterm (Grammar.Entry.obj (expr : 'expr Grammar.Entry.e));
       Gramext.Stoken ("", "in")],
      Gramext.action
        (fun _ (e : 'expr) _ (p : 'ipatt) _ (loc : Ploc.t) ->
           (SpLet (loc, p, e), SpoNoth : 'stream_patt_let))]];
    Grammar.Entry.obj (lookahead : 'lookahead Grammar.Entry.e), None,
    [None, None,
     [[Gramext.Stoken ("", "[");
       Gramext.Slist1sep
         (Gramext.Snterm (Grammar.Entry.obj (patt : 'patt Grammar.Entry.e)),
          Gramext.Stoken ("", ";"), false);
       Gramext.Stoken ("", "]")],
      Gramext.action
        (fun _ (pl : 'patt list) _ (loc : Ploc.t) -> (pl : 'lookahead))]];
    Grammar.Entry.obj (expr : 'expr Grammar.Entry.e),
    Some (Gramext.Level "simple"),
    [None, None,
     [[Gramext.Stoken ("", "[:");
       Gramext.Slist0sep
         (Gramext.Snterm
            (Grammar.Entry.obj
               (stream_expr_comp : 'stream_expr_comp Grammar.Entry.e)),
          Gramext.Stoken ("", ";"), false);
       Gramext.Stoken ("", ":]")],
      Gramext.action
        (fun _ (se : 'stream_expr_comp list) _ (loc : Ploc.t) ->
           (cstream loc se : 'expr))]];
    Grammar.Entry.obj (stream_expr_comp : 'stream_expr_comp Grammar.Entry.e),
    None,
    [None, None,
     [[Gramext.Snterm (Grammar.Entry.obj (expr : 'expr Grammar.Entry.e))],
      Gramext.action
        (fun (e : 'expr) (loc : Ploc.t) ->
           (SeNtr (loc, e) : 'stream_expr_comp));
      [Gramext.Stoken ("", "`");
       Gramext.Snterm (Grammar.Entry.obj (expr : 'expr Grammar.Entry.e))],
      Gramext.action
        (fun (e : 'expr) _ (loc : Ploc.t) ->
           (SeTrm (loc, e) : 'stream_expr_comp))]]]);;
