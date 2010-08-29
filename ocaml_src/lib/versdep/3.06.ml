(* camlp5r pa_macro.cmo *)
(* This file has been generated by program: do not edit! *)
(* Copyright (c) INRIA 2007-2010 *)

open Parsetree;;
open Longident;;
open Asttypes;;

(* *)
(* *)
(* *)
(* *)
(* *)
(* *)

type ('a, 'b) choice =
    Left of 'a
  | Right of 'b
;;

let sys_ocaml_version = Sys.ocaml_version;;

let ocaml_location (fname, lnum, bolp, bp, ep) =
  {Location.loc_start = bp; Location.loc_end = ep;
   Location.loc_ghost = bp = 0 && ep = 0}
;;

let ocaml_ptyp_poly = Some (fun cl t -> Ptyp_poly (cl, t));;

let ocaml_type_declaration params cl tk pf tm loc variance =
  {ptype_params = params; ptype_cstrs = cl; ptype_kind = tk;
   ptype_manifest = tm; ptype_loc = loc; ptype_variance = variance}
;;

let ocaml_ptype_record ltl priv =
  let ltl = List.map (fun (n, m, t, _) -> n, m, t) ltl in Ptype_record ltl
;;

let ocaml_ptype_variant ctl priv =
  let ctl = List.map (fun (c, tl, _) -> c, tl) ctl in Ptype_variant ctl
;;

let ocaml_ptyp_variant catl clos sl_opt =
  let catl =
    List.map
      (function
         Left (c, a, tl) -> Rtag (c, a, tl)
       | Right t -> Rinherit t)
      catl
  in
  Some (Ptyp_variant (catl, clos, sl_opt))
;;

let ocaml_ptype_private = Ptype_abstract;;

let ocaml_pwith_type params tk pf ct variance loc =
  Pwith_type
    {ptype_params = params; ptype_cstrs = []; ptype_kind = tk;
     ptype_manifest = ct; ptype_variance = variance; ptype_loc = loc}
;;

let ocaml_pexp_lazy = Some (fun e -> Pexp_lazy e);;

let ocaml_const_int32 = None;;

let ocaml_const_int64 = None;;

let ocaml_const_nativeint = None;;

let ocaml_pexp_object = None;;

let module_prefix_can_be_in_first_record_label_only = false;;

let ocaml_ppat_lazy = None;;

let ocaml_ppat_record lpl = Ppat_record lpl;;

let ocaml_psig_recmodule = None;;

let ocaml_pstr_recmodule = None;;

let ocaml_pctf_val (s, b, t, loc) = Pctf_val (s, b, Some t, loc);;

let ocaml_pcf_inher ce pb = Pcf_inher (ce, pb);;

let ocaml_pcf_meth (s, b, e, loc) = Pcf_meth (s, b, e, loc);;

let ocaml_pcf_val (s, b, e, loc) = Pcf_val (s, b, e, loc);;

let ocaml_pexp_poly = Some (fun e t -> Pexp_poly (e, t));;

let arg_set_string _ = None;;

let arg_set_int _ = None;;

let arg_set_float _ = None;;

let arg_symbol _ = None;;

let arg_tuple _ = None;;

let arg_bool _ = None;;

let printf_ksprintf = Printf.kprintf;;
