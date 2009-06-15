(* camlp5r *)
(* This file has been generated by program: do not edit! *)

(* #load "pa_extend.cmo";; *)
(* #load "q_MLast.cmo";; *)

open Printf;;

let not_impl f x =
  let desc =
    if Obj.is_block (Obj.repr x) then
      "tag = " ^ string_of_int (Obj.tag (Obj.repr x))
    else "int_val = " ^ string_of_int (Obj.magic x)
  in
  failwith ("q_ast.ml: " ^ f ^ ", not impl: " ^ desc)
;;

let call_with r v f a =
  let saved = !r in
  try r := v; let b = f a in r := saved; b with e -> r := saved; raise e
;;

let eval_antiquot entry s =
  try
    let i = String.index s ',' in
    let j = String.index_from s (i + 1) ':' in
    let k = String.index_from s (j + 1) ':' in
    let bp = int_of_string (String.sub s 0 i) in
    let ep = int_of_string (String.sub s (i + 1) (j - i - 1)) in
    let sh = int_of_string (String.sub s (j + 1) (k - j - 1)) in
    let str = String.sub s (k + 1) (String.length s - k - 1) in
    let r =
      call_with Plexer.dollar_for_antiquot_loc false
        (Grammar.Entry.parse entry) (Stream.of_string str)
    in
    let loc =
      let shift_bp = String.length "$" + sh in
      let shift_ep = String.length "$" in
      Stdpp.make_loc (bp + shift_bp, ep - shift_ep)
    in
    Some (loc, r)
  with Not_found -> None
;;

(* horrible hack for opt antiquotations; a string has been installed in
   the ASt at the place of a list, an option or a bool, using Obj.repr;
   ugly but local to q_ast.ml *)
let eval_antiquot_patch entry v =
  if Obj.is_block (Obj.repr v) && Obj.tag (Obj.repr v) = Obj.string_tag then
    let s : string = Obj.magic v in
    match eval_antiquot entry s with
      Some loc_r -> Some loc_r
    | None -> assert false
  else None
;;

let expr_eoi = Grammar.Entry.create Pcaml.gram "expr";;
let patt_eoi = Grammar.Entry.create Pcaml.gram "patt";;
let str_item_eoi = Grammar.Entry.create Pcaml.gram "str_item";;
let sig_item_eoi = Grammar.Entry.create Pcaml.gram "sig_item";;
let module_expr_eoi = Grammar.Entry.create Pcaml.gram "module_expr";;

module Meta =
  struct
    open MLast;;
    let loc = Stdpp.dummy_loc;;
    let ln () = MLast.ExLid (loc, !(Stdpp.loc_name));;
    let e_list elem el =
      match eval_antiquot_patch expr_eoi el with
        Some (loc, r) -> MLast.ExAnt (loc, r)
      | None ->
          let rec loop =
            function
              [] -> MLast.ExUid (loc, "[]")
            | e :: el ->
                MLast.ExApp
                  (loc, MLast.ExApp (loc, MLast.ExUid (loc, "::"), elem e),
                   loop el)
          in
          loop el
    ;;
    let p_list elem el =
      match eval_antiquot_patch patt_eoi el with
        Some (loc, r) -> MLast.PaAnt (loc, r)
      | None ->
          let rec loop =
            function
              [] -> MLast.PaUid (loc, "[]")
            | e :: el ->
                MLast.PaApp
                  (loc, MLast.PaApp (loc, MLast.PaUid (loc, "::"), elem e),
                   loop el)
          in
          loop el
    ;;
    let e_option elem eo =
      match eval_antiquot_patch expr_eoi eo with
        Some (loc, r) -> MLast.ExAnt (loc, r)
      | None ->
          match eo with
            None -> MLast.ExUid (loc, "None")
          | Some e -> MLast.ExApp (loc, MLast.ExUid (loc, "Some"), elem e)
    ;;
    let e_bool b =
      match eval_antiquot_patch expr_eoi b with
        Some (loc, r) -> MLast.ExAnt (loc, r)
      | None ->
          if b then MLast.ExUid (loc, "True") else MLast.ExUid (loc, "False")
    ;;
    let p_bool b =
      match eval_antiquot_patch patt_eoi b with
        Some (loc, r) -> MLast.PaAnt (loc, r)
      | None ->
          if b then MLast.PaUid (loc, "True") else MLast.PaUid (loc, "False")
    ;;
    let e_string s =
      match eval_antiquot expr_eoi s with
        Some (loc, r) -> MLast.ExAnt (loc, r)
      | None -> MLast.ExStr (loc, s)
    ;;
    let p_string s =
      match eval_antiquot patt_eoi s with
        Some (loc, r) -> MLast.PaAnt (loc, r)
      | None -> MLast.PaStr (loc, s)
    ;;
    let e_type t =
      let ln = ln () in
      let rec loop =
        function
          TyAcc (_, t1, t2) ->
            MLast.ExApp
              (loc,
               MLast.ExApp
                 (loc,
                  MLast.ExApp
                    (loc,
                     MLast.ExAcc
                       (loc, MLast.ExUid (loc, "MLast"),
                        MLast.ExUid (loc, "TyAcc")),
                     ln),
                  loop t1),
               loop t2)
        | TyAny _ ->
            MLast.ExApp
              (loc,
               MLast.ExAcc
                 (loc, MLast.ExUid (loc, "MLast"),
                  MLast.ExUid (loc, "TyAny")),
               ln)
        | TyApp (_, t1, t2) ->
            MLast.ExApp
              (loc,
               MLast.ExApp
                 (loc,
                  MLast.ExApp
                    (loc,
                     MLast.ExAcc
                       (loc, MLast.ExUid (loc, "MLast"),
                        MLast.ExUid (loc, "TyApp")),
                     ln),
                  loop t1),
               loop t2)
        | TyLid (_, s) ->
            MLast.ExApp
              (loc,
               MLast.ExApp
                 (loc,
                  MLast.ExAcc
                    (loc, MLast.ExUid (loc, "MLast"),
                     MLast.ExUid (loc, "TyLid")),
                  ln),
               e_string s)
        | TyQuo (_, s) ->
            MLast.ExApp
              (loc,
               MLast.ExApp
                 (loc,
                  MLast.ExAcc
                    (loc, MLast.ExUid (loc, "MLast"),
                     MLast.ExUid (loc, "TyQuo")),
                  ln),
               e_string s)
        | TyUid (_, s) ->
            MLast.ExApp
              (loc,
               MLast.ExApp
                 (loc,
                  MLast.ExAcc
                    (loc, MLast.ExUid (loc, "MLast"),
                     MLast.ExUid (loc, "TyUid")),
                  ln),
               e_string s)
        | x -> not_impl "e_type" x
      in
      loop t
    ;;
    let p_type =
      function
        TyLid (_, s) ->
          MLast.PaApp
            (loc,
             MLast.PaApp
               (loc,
                MLast.PaAcc
                  (loc, MLast.PaUid (loc, "MLast"),
                   MLast.PaUid (loc, "TyLid")),
                MLast.PaAny loc),
             p_string s)
      | x -> not_impl "p_type" x
    ;;
    let e_type_decl x = not_impl "e_type_decl" x;;
    let e_patt p =
      let ln = ln () in
      let rec loop =
        function
          PaAcc (_, p1, p2) ->
            MLast.ExApp
              (loc,
               MLast.ExApp
                 (loc,
                  MLast.ExApp
                    (loc,
                     MLast.ExAcc
                       (loc, MLast.ExUid (loc, "MLast"),
                        MLast.ExUid (loc, "PaAcc")),
                     ln),
                  loop p1),
               loop p2)
        | PaAli (_, p1, p2) ->
            MLast.ExApp
              (loc,
               MLast.ExApp
                 (loc,
                  MLast.ExApp
                    (loc,
                     MLast.ExAcc
                       (loc, MLast.ExUid (loc, "MLast"),
                        MLast.ExUid (loc, "PaAli")),
                     ln),
                  loop p1),
               loop p2)
        | PaAnt (_, p) ->
            begin match p with
              PaLid (_, s) ->
                begin match eval_antiquot expr_eoi s with
                  Some (loc, r) ->
                    let r =
                      MLast.ExApp
                        (loc,
                         MLast.ExApp
                           (loc,
                            MLast.ExAcc
                              (loc, MLast.ExUid (loc, "MLast"),
                               MLast.ExUid (loc, "PaAnt")),
                            ln),
                         r)
                    in
                    MLast.ExAnt (loc, r)
                | None -> assert false
                end
            | PaStr (_, s) ->
                begin match eval_antiquot expr_eoi s with
                  Some (loc, r) -> MLast.ExAnt (loc, r)
                | None -> assert false
                end
            | _ -> assert false
            end
        | PaAny _ ->
            MLast.ExApp
              (loc,
               MLast.ExAcc
                 (loc, MLast.ExUid (loc, "MLast"),
                  MLast.ExUid (loc, "PaAny")),
               ln)
        | PaApp (_, p1, p2) ->
            MLast.ExApp
              (loc,
               MLast.ExApp
                 (loc,
                  MLast.ExApp
                    (loc,
                     MLast.ExAcc
                       (loc, MLast.ExUid (loc, "MLast"),
                        MLast.ExUid (loc, "PaApp")),
                     ln),
                  loop p1),
               loop p2)
        | PaInt (_, s, k) ->
            MLast.ExApp
              (loc,
               MLast.ExApp
                 (loc,
                  MLast.ExApp
                    (loc,
                     MLast.ExAcc
                       (loc, MLast.ExUid (loc, "MLast"),
                        MLast.ExUid (loc, "PaInt")),
                     ln),
                  e_string s),
               MLast.ExStr (loc, k))
        | PaFlo (_, s) ->
            MLast.ExApp
              (loc,
               MLast.ExApp
                 (loc,
                  MLast.ExAcc
                    (loc, MLast.ExUid (loc, "MLast"),
                     MLast.ExUid (loc, "PaFlo")),
                  ln),
               e_string s)
        | PaLid (_, s) ->
            MLast.ExApp
              (loc,
               MLast.ExApp
                 (loc,
                  MLast.ExAcc
                    (loc, MLast.ExUid (loc, "MLast"),
                     MLast.ExUid (loc, "PaLid")),
                  ln),
               e_string s)
        | PaStr (_, s) ->
            MLast.ExApp
              (loc,
               MLast.ExApp
                 (loc,
                  MLast.ExAcc
                    (loc, MLast.ExUid (loc, "MLast"),
                     MLast.ExUid (loc, "PaStr")),
                  ln),
               e_string s)
        | PaTyc (_, p, t) ->
            MLast.ExApp
              (loc,
               MLast.ExApp
                 (loc,
                  MLast.ExApp
                    (loc,
                     MLast.ExAcc
                       (loc, MLast.ExUid (loc, "MLast"),
                        MLast.ExUid (loc, "PaTyc")),
                     ln),
                  loop p),
               e_type t)
        | PaUid (_, s) ->
            MLast.ExApp
              (loc,
               MLast.ExApp
                 (loc,
                  MLast.ExAcc
                    (loc, MLast.ExUid (loc, "MLast"),
                     MLast.ExUid (loc, "PaUid")),
                  ln),
               e_string s)
        | x -> not_impl "e_patt" x
      in
      loop p
    ;;
    let p_patt x = not_impl "p_patt" x;;
    let e_expr e =
      let ln = ln () in
      let rec loop =
        function
          ExAcc (_, e1, e2) ->
            MLast.ExApp
              (loc,
               MLast.ExApp
                 (loc,
                  MLast.ExApp
                    (loc,
                     MLast.ExAcc
                       (loc, MLast.ExUid (loc, "MLast"),
                        MLast.ExUid (loc, "ExAcc")),
                     ln),
                  loop e1),
               loop e2)
        | ExAnt (_, e) ->
            begin match e with
              ExLid (_, s) ->
                begin match eval_antiquot expr_eoi s with
                  Some (loc, r) ->
                    let r =
                      MLast.ExApp
                        (loc,
                         MLast.ExApp
                           (loc,
                            MLast.ExAcc
                              (loc, MLast.ExUid (loc, "MLast"),
                               MLast.ExUid (loc, "ExAnt")),
                            ln),
                         r)
                    in
                    MLast.ExAnt (loc, r)
                | None -> assert false
                end
            | ExStr (_, s) ->
                begin match eval_antiquot expr_eoi s with
                  Some (loc, r) -> MLast.ExAnt (loc, r)
                | None -> assert false
                end
            | _ -> assert false
            end
        | ExApp (_, e1, e2) ->
            MLast.ExApp
              (loc,
               MLast.ExApp
                 (loc,
                  MLast.ExApp
                    (loc,
                     MLast.ExAcc
                       (loc, MLast.ExUid (loc, "MLast"),
                        MLast.ExUid (loc, "ExApp")),
                     ln),
                  loop e1),
               loop e2)
        | ExArr (_, el) ->
            MLast.ExApp
              (loc,
               MLast.ExApp
                 (loc,
                  MLast.ExAcc
                    (loc, MLast.ExUid (loc, "MLast"),
                     MLast.ExUid (loc, "ExArr")),
                  ln),
               e_list loop el)
        | ExIfe (_, e1, e2, e3) ->
            MLast.ExApp
              (loc,
               MLast.ExApp
                 (loc,
                  MLast.ExApp
                    (loc,
                     MLast.ExApp
                       (loc,
                        MLast.ExAcc
                          (loc, MLast.ExUid (loc, "MLast"),
                           MLast.ExUid (loc, "ExIfe")),
                        ln),
                     loop e1),
                  loop e2),
               loop e3)
        | ExInt (_, s, k) ->
            MLast.ExApp
              (loc,
               MLast.ExApp
                 (loc,
                  MLast.ExApp
                    (loc,
                     MLast.ExAcc
                       (loc, MLast.ExUid (loc, "MLast"),
                        MLast.ExUid (loc, "ExInt")),
                     ln),
                  e_string s),
               MLast.ExStr (loc, k))
        | ExFlo (_, s) ->
            MLast.ExApp
              (loc,
               MLast.ExApp
                 (loc,
                  MLast.ExAcc
                    (loc, MLast.ExUid (loc, "MLast"),
                     MLast.ExUid (loc, "ExFlo")),
                  ln),
               e_string s)
        | ExFun (_, pwel) ->
            let pwel =
              e_list
                (fun (p, eo, e) ->
                   MLast.ExTup (loc, [e_patt p; e_option loop eo; loop e]))
                pwel
            in
            MLast.ExApp
              (loc,
               MLast.ExApp
                 (loc,
                  MLast.ExAcc
                    (loc, MLast.ExUid (loc, "MLast"),
                     MLast.ExUid (loc, "ExFun")),
                  ln),
               pwel)
        | ExLet (_, rf, lpe, e) ->
            let rf = e_bool rf in
            let lpe =
              e_list (fun (p, e) -> MLast.ExTup (loc, [e_patt p; loop e])) lpe
            in
            MLast.ExApp
              (loc,
               MLast.ExApp
                 (loc,
                  MLast.ExApp
                    (loc,
                     MLast.ExApp
                       (loc,
                        MLast.ExAcc
                          (loc, MLast.ExUid (loc, "MLast"),
                           MLast.ExUid (loc, "ExLet")),
                        ln),
                     rf),
                  lpe),
               loop e)
        | ExLid (_, s) ->
            MLast.ExApp
              (loc,
               MLast.ExApp
                 (loc,
                  MLast.ExAcc
                    (loc, MLast.ExUid (loc, "MLast"),
                     MLast.ExUid (loc, "ExLid")),
                  ln),
               e_string s)
        | ExMat (_, e, pwel) ->
            let pwel =
              e_list
                (fun (p, eo, e) ->
                   MLast.ExTup (loc, [e_patt p; e_option loop eo; loop e]))
                pwel
            in
            MLast.ExApp
              (loc,
               MLast.ExApp
                 (loc,
                  MLast.ExApp
                    (loc,
                     MLast.ExAcc
                       (loc, MLast.ExUid (loc, "MLast"),
                        MLast.ExUid (loc, "ExMat")),
                     ln),
                  loop e),
               pwel)
        | ExSeq (_, el) ->
            MLast.ExApp
              (loc,
               MLast.ExApp
                 (loc,
                  MLast.ExAcc
                    (loc, MLast.ExUid (loc, "MLast"),
                     MLast.ExUid (loc, "ExSeq")),
                  ln),
               e_list loop el)
        | ExStr (_, s) ->
            MLast.ExApp
              (loc,
               MLast.ExApp
                 (loc,
                  MLast.ExAcc
                    (loc, MLast.ExUid (loc, "MLast"),
                     MLast.ExUid (loc, "ExStr")),
                  ln),
               e_string s)
        | ExTup (_, e :: el) ->
            let el =
              MLast.ExApp
                (loc, MLast.ExApp (loc, MLast.ExUid (loc, "::"), loop e),
                 e_list loop el)
            in
            MLast.ExApp
              (loc,
               MLast.ExApp
                 (loc,
                  MLast.ExAcc
                    (loc, MLast.ExUid (loc, "MLast"),
                     MLast.ExUid (loc, "ExTup")),
                  ln),
               el)
        | ExTyc (_, e, t) ->
            MLast.ExApp
              (loc,
               MLast.ExApp
                 (loc,
                  MLast.ExApp
                    (loc,
                     MLast.ExAcc
                       (loc, MLast.ExUid (loc, "MLast"),
                        MLast.ExUid (loc, "ExTyc")),
                     ln),
                  loop e),
               e_type t)
        | ExUid (_, s) ->
            MLast.ExApp
              (loc,
               MLast.ExApp
                 (loc,
                  MLast.ExAcc
                    (loc, MLast.ExUid (loc, "MLast"),
                     MLast.ExUid (loc, "ExUid")),
                  ln),
               e_string s)
        | x -> not_impl "e_expr" x
      in
      loop e
    ;;
    let p_expr e =
      let rec loop =
        function
          ExAcc (_, e1, e2) ->
            MLast.PaApp
              (loc,
               MLast.PaApp
                 (loc,
                  MLast.PaApp
                    (loc,
                     MLast.PaAcc
                       (loc, MLast.PaUid (loc, "MLast"),
                        MLast.PaUid (loc, "ExAcc")),
                     MLast.PaAny loc),
                  loop e1),
               loop e2)
        | ExAnt (_, e) ->
            begin match e with
              ExLid (_, s) ->
                begin match eval_antiquot patt_eoi s with
                  Some (loc, r) ->
                    let r =
                      MLast.PaApp
                        (loc,
                         MLast.PaApp
                           (loc,
                            MLast.PaAcc
                              (loc, MLast.PaUid (loc, "MLast"),
                               MLast.PaUid (loc, "ExAnt")),
                            MLast.PaAny loc),
                         r)
                    in
                    MLast.PaAnt (loc, r)
                | None -> assert false
                end
            | ExStr (_, s) ->
                begin match eval_antiquot patt_eoi s with
                  Some (loc, r) -> MLast.PaAnt (loc, r)
                | None -> assert false
                end
            | _ -> assert false
            end
        | ExInt (_, s, k) ->
            MLast.PaApp
              (loc,
               MLast.PaApp
                 (loc,
                  MLast.PaApp
                    (loc,
                     MLast.PaAcc
                       (loc, MLast.PaUid (loc, "MLast"),
                        MLast.PaUid (loc, "ExInt")),
                     MLast.PaAny loc),
                  p_string s),
               MLast.PaStr (loc, k))
        | ExFlo (_, s) ->
            MLast.PaApp
              (loc,
               MLast.PaApp
                 (loc,
                  MLast.PaAcc
                    (loc, MLast.PaUid (loc, "MLast"),
                     MLast.PaUid (loc, "ExFlo")),
                  MLast.PaAny loc),
               p_string s)
        | ExLet (_, rf, lpe, e) ->
            let rf = p_bool rf in
            let lpe =
              p_list (fun (p, e) -> MLast.PaTup (loc, [p_patt p; loop e])) lpe
            in
            MLast.PaApp
              (loc,
               MLast.PaApp
                 (loc,
                  MLast.PaApp
                    (loc,
                     MLast.PaApp
                       (loc,
                        MLast.PaAcc
                          (loc, MLast.PaUid (loc, "MLast"),
                           MLast.PaUid (loc, "ExLet")),
                        MLast.PaAny loc),
                     rf),
                  lpe),
               loop e)
        | x -> not_impl "p_expr" x
      in
      loop e
    ;;
    let e_sig_item =
      function
        SgVal (_, s, t) ->
          MLast.ExApp
            (loc,
             MLast.ExApp
               (loc,
                MLast.ExApp
                  (loc,
                   MLast.ExAcc
                     (loc, MLast.ExUid (loc, "MLast"),
                      MLast.ExUid (loc, "SgVal")),
                   ln ()),
                e_string s),
             e_type t)
      | x -> not_impl "e_sig_item" x
    ;;
    let e_module_type mt =
      let ln = ln () in
      let rec loop =
        function
          MtUid (_, s) ->
            MLast.ExApp
              (loc,
               MLast.ExApp
                 (loc,
                  MLast.ExAcc
                    (loc, MLast.ExUid (loc, "MLast"),
                     MLast.ExUid (loc, "MtUid")),
                  ln),
               e_string s)
        | x -> not_impl "e_module_type" x
      in
      loop mt
    ;;
    let rec e_str_item si =
      let ln = ln () in
      let rec loop =
        function
          StDcl (_, lsi) ->
            MLast.ExApp
              (loc,
               MLast.ExApp
                 (loc,
                  MLast.ExAcc
                    (loc, MLast.ExUid (loc, "MLast"),
                     MLast.ExUid (loc, "StDcl")),
                  ln),
               e_list loop lsi)
        | StExc (_, s, lt, ls) ->
            let ls =
              match eval_antiquot_patch expr_eoi ls with
                Some (loc, r) -> MLast.ExAnt (loc, r)
              | None -> e_list e_string ls
            in
            MLast.ExApp
              (loc,
               MLast.ExApp
                 (loc,
                  MLast.ExApp
                    (loc,
                     MLast.ExApp
                       (loc,
                        MLast.ExAcc
                          (loc, MLast.ExUid (loc, "MLast"),
                           MLast.ExUid (loc, "StExc")),
                        ln),
                     e_string s),
                  e_list e_type lt),
               ls)
        | StExp (_, e) ->
            MLast.ExApp
              (loc,
               MLast.ExApp
                 (loc,
                  MLast.ExAcc
                    (loc, MLast.ExUid (loc, "MLast"),
                     MLast.ExUid (loc, "StExp")),
                  ln),
               e_expr e)
        | StExt (_, s, t, ls) ->
            let ls = e_list e_string ls in
            MLast.ExApp
              (loc,
               MLast.ExApp
                 (loc,
                  MLast.ExApp
                    (loc,
                     MLast.ExApp
                       (loc,
                        MLast.ExAcc
                          (loc, MLast.ExUid (loc, "MLast"),
                           MLast.ExUid (loc, "StExt")),
                        ln),
                     e_string s),
                  e_type t),
               ls)
        | StInc (_, me) ->
            MLast.ExApp
              (loc,
               MLast.ExApp
                 (loc,
                  MLast.ExAcc
                    (loc, MLast.ExUid (loc, "MLast"),
                     MLast.ExUid (loc, "StInc")),
                  ln),
               e_module_expr me)
        | StMod (_, rf, lsme) ->
            let lsme =
              e_list
                (fun (s, me) ->
                   MLast.ExTup (loc, [e_string s; e_module_expr me]))
                lsme
            in
            MLast.ExApp
              (loc,
               MLast.ExApp
                 (loc,
                  MLast.ExApp
                    (loc,
                     MLast.ExAcc
                       (loc, MLast.ExUid (loc, "MLast"),
                        MLast.ExUid (loc, "StMod")),
                     ln),
                  e_bool rf),
               lsme)
        | StMty (_, s, mt) ->
            MLast.ExApp
              (loc,
               MLast.ExApp
                 (loc,
                  MLast.ExApp
                    (loc,
                     MLast.ExAcc
                       (loc, MLast.ExUid (loc, "MLast"),
                        MLast.ExUid (loc, "StMty")),
                     ln),
                  e_string s),
               e_module_type mt)
        | StOpn (_, sl) ->
            MLast.ExApp
              (loc,
               MLast.ExApp
                 (loc,
                  MLast.ExAcc
                    (loc, MLast.ExUid (loc, "MLast"),
                     MLast.ExUid (loc, "StOpn")),
                  ln),
               e_list e_string sl)
        | StTyp (_, ltd) ->
            MLast.ExApp
              (loc,
               MLast.ExApp
                 (loc,
                  MLast.ExAcc
                    (loc, MLast.ExUid (loc, "MLast"),
                     MLast.ExUid (loc, "StTyp")),
                  ln),
               e_list e_type_decl ltd)
        | StVal (_, rf, lpe) ->
            let lpe =
              e_list (fun (p, e) -> MLast.ExTup (loc, [e_patt p; e_expr e]))
                lpe
            in
            MLast.ExApp
              (loc,
               MLast.ExApp
                 (loc,
                  MLast.ExApp
                    (loc,
                     MLast.ExAcc
                       (loc, MLast.ExUid (loc, "MLast"),
                        MLast.ExUid (loc, "StVal")),
                     ln),
                  e_bool rf),
               lpe)
        | x -> not_impl "e_str_item" x
      in
      loop si
    and p_str_item x = not_impl "p_str_item" x
    and e_module_expr me =
      let ln = ln () in
      let rec loop =
        function
          MeAcc (_, me1, me2) ->
            MLast.ExApp
              (loc,
               MLast.ExApp
                 (loc,
                  MLast.ExApp
                    (loc,
                     MLast.ExAcc
                       (loc, MLast.ExUid (loc, "MLast"),
                        MLast.ExUid (loc, "MeAcc")),
                     ln),
                  loop me1),
               loop me2)
        | MeApp (_, me1, me2) ->
            MLast.ExApp
              (loc,
               MLast.ExApp
                 (loc,
                  MLast.ExApp
                    (loc,
                     MLast.ExAcc
                       (loc, MLast.ExUid (loc, "MLast"),
                        MLast.ExUid (loc, "MeApp")),
                     ln),
                  loop me1),
               loop me2)
        | MeFun (_, s, mt, me) ->
            let mt = e_module_type mt in
            MLast.ExApp
              (loc,
               MLast.ExApp
                 (loc,
                  MLast.ExApp
                    (loc,
                     MLast.ExApp
                       (loc,
                        MLast.ExAcc
                          (loc, MLast.ExUid (loc, "MLast"),
                           MLast.ExUid (loc, "Mefun")),
                        ln),
                     e_string s),
                  mt),
               loop me)
        | MeStr (_, lsi) ->
            MLast.ExApp
              (loc,
               MLast.ExApp
                 (loc,
                  MLast.ExAcc
                    (loc, MLast.ExUid (loc, "MLast"),
                     MLast.ExUid (loc, "MeStr")),
                  ln),
               e_list e_str_item lsi)
        | MeTyc (_, me, mt) ->
            let mt = e_module_type mt in
            MLast.ExApp
              (loc,
               MLast.ExApp
                 (loc,
                  MLast.ExApp
                    (loc,
                     MLast.ExAcc
                       (loc, MLast.ExUid (loc, "MLast"),
                        MLast.ExUid (loc, "MeTyc")),
                     ln),
                  loop me),
               mt)
        | MeUid (_, s) ->
            MLast.ExApp
              (loc,
               MLast.ExApp
                 (loc,
                  MLast.ExAcc
                    (loc, MLast.ExUid (loc, "MLast"),
                     MLast.ExUid (loc, "MeUid")),
                  ln),
               e_string s)
      in
      loop me
    and p_module_expr x = not_impl "p_module_expr" x;;
    let p_sig_item =
      function
        SgVal (_, s, t) ->
          MLast.PaApp
            (loc,
             MLast.PaApp
               (loc,
                MLast.PaApp
                  (loc,
                   MLast.PaAcc
                     (loc, MLast.PaUid (loc, "MLast"),
                      MLast.PaUid (loc, "SgVal")),
                   MLast.PaAny loc),
                p_string s),
             p_type t)
      | x -> not_impl "p_sig_item" x
    ;;
  end
;;

Grammar.extend
  [Grammar.Entry.obj (expr_eoi : 'expr_eoi Grammar.Entry.e), None,
   [None, None,
    [[Gramext.Snterm
        (Grammar.Entry.obj (Pcaml.expr : 'Pcaml__expr Grammar.Entry.e));
      Gramext.Stoken ("EOI", "")],
     Gramext.action
       (fun _ (x : 'Pcaml__expr) (loc : Token.location) -> (x : 'expr_eoi))]];
   Grammar.Entry.obj (patt_eoi : 'patt_eoi Grammar.Entry.e), None,
   [None, None,
    [[Gramext.Snterm
        (Grammar.Entry.obj (Pcaml.patt : 'Pcaml__patt Grammar.Entry.e));
      Gramext.Stoken ("EOI", "")],
     Gramext.action
       (fun _ (x : 'Pcaml__patt) (loc : Token.location) -> (x : 'patt_eoi))]];
   Grammar.Entry.obj (sig_item_eoi : 'sig_item_eoi Grammar.Entry.e), None,
   [None, None,
    [[Gramext.Snterm
        (Grammar.Entry.obj
           (Pcaml.sig_item : 'Pcaml__sig_item Grammar.Entry.e));
      Gramext.Stoken ("EOI", "")],
     Gramext.action
       (fun _ (x : 'Pcaml__sig_item) (loc : Token.location) ->
          (x : 'sig_item_eoi))]];
   Grammar.Entry.obj (str_item_eoi : 'str_item_eoi Grammar.Entry.e), None,
   [None, None,
    [[Gramext.Snterm
        (Grammar.Entry.obj
           (Pcaml.str_item : 'Pcaml__str_item Grammar.Entry.e));
      Gramext.Stoken ("EOI", "")],
     Gramext.action
       (fun _ (x : 'Pcaml__str_item) (loc : Token.location) ->
          (x : 'str_item_eoi))]];
   Grammar.Entry.obj (module_expr_eoi : 'module_expr_eoi Grammar.Entry.e),
   None,
   [None, None,
    [[Gramext.Snterm
        (Grammar.Entry.obj
           (Pcaml.module_expr : 'Pcaml__module_expr Grammar.Entry.e));
      Gramext.Stoken ("EOI", "")],
     Gramext.action
       (fun _ (x : 'Pcaml__module_expr) (loc : Token.location) ->
          (x : 'module_expr_eoi))]];
   Grammar.Entry.obj (Pcaml.expr : 'Pcaml__expr Grammar.Entry.e), None,
   [None, None,
    [[Gramext.Stoken ("", "do"); Gramext.Stoken ("", "{");
      Gramext.Slist0sep
        (Gramext.Snterm
           (Grammar.Entry.obj (Pcaml.expr : 'Pcaml__expr Grammar.Entry.e)),
         Gramext.Stoken ("", ";"));
      Gramext.Stoken ("", "}")],
     Gramext.action
       (fun _ (el : 'Pcaml__expr list) _ _ (loc : Token.location) ->
          (MLast.ExSeq (loc, el) : 'Pcaml__expr))]];
   Grammar.Entry.obj (Pcaml.expr : 'Pcaml__expr Grammar.Entry.e),
   Some (Gramext.Level "simple"),
   [None, None,
    [[Gramext.Stoken ("ANTIQUOT_LOC", "")],
     Gramext.action
       (fun (s : string) (loc : Token.location) ->
          (MLast.ExAnt (loc, MLast.ExStr (loc, s)) : 'Pcaml__expr));
     [Gramext.Stoken ("ANTIQUOT_LOC", "anti")],
     Gramext.action
       (fun (s : string) (loc : Token.location) ->
          (MLast.ExAnt (loc, MLast.ExLid (loc, s)) : 'Pcaml__expr))]];
   Grammar.Entry.obj (Pcaml.patt : 'Pcaml__patt Grammar.Entry.e),
   Some (Gramext.Level "simple"),
   [None, None,
    [[Gramext.Stoken ("ANTIQUOT_LOC", "")],
     Gramext.action
       (fun (s : string) (loc : Token.location) ->
          (MLast.PaAnt (loc, MLast.PaStr (loc, s)) : 'Pcaml__patt));
     [Gramext.Stoken ("ANTIQUOT_LOC", "anti")],
     Gramext.action
       (fun (s : string) (loc : Token.location) ->
          (MLast.PaAnt (loc, MLast.PaLid (loc, s)) : 'Pcaml__patt))]];
   Grammar.Entry.obj (Pcaml.ctyp : 'Pcaml__ctyp Grammar.Entry.e),
   Some (Gramext.Level "simple"),
   [None, None,
    [[Gramext.Stoken ("ANTIQUOT_LOC", "")],
     Gramext.action
       (fun (s : string) (loc : Token.location) ->
          (MLast.TyUid (loc, s) : 'Pcaml__ctyp))]];
   Grammar.Entry.obj (Pcaml.str_item : 'Pcaml__str_item Grammar.Entry.e),
   None,
   [None, None,
    [[Gramext.Stoken ("ANTIQUOT_LOC", "exp")],
     Gramext.action
       (fun (s : string) (loc : Token.location) ->
          (let e = MLast.ExAnt (loc, MLast.ExLid (loc, s)) in
           MLast.StExp (loc, e) :
           'Pcaml__str_item))]];
   Grammar.Entry.obj
     (Pcaml.module_expr : 'Pcaml__module_expr Grammar.Entry.e),
   Some (Gramext.Level "simple"),
   [None, None,
    [[Gramext.Stoken ("ANTIQUOT_LOC", "")],
     Gramext.action
       (fun (s : string) (loc : Token.location) ->
          (MLast.MeUid (loc, s) : 'Pcaml__module_expr))]];
   Grammar.Entry.obj
     (Pcaml.module_type : 'Pcaml__module_type Grammar.Entry.e),
   Some (Gramext.Level "simple"),
   [None, None,
    [[Gramext.Stoken ("ANTIQUOT_LOC", "")],
     Gramext.action
       (fun (s : string) (loc : Token.location) ->
          (MLast.MtUid (loc, s) : 'Pcaml__module_type))]]];;

let mod_ident = Grammar.Entry.find Pcaml.str_item "mod_ident" in
Grammar.extend
  [Grammar.Entry.obj (mod_ident : 'mod_ident Grammar.Entry.e),
   Some Gramext.First,
   [None, None,
    [[Gramext.Stoken ("ANTIQUOT_LOC", "")],
     Gramext.action
       (fun (s : string) (loc : Token.location) ->
          (Obj.repr s : 'mod_ident))]]];;

let eq_before_colon p e =
  let rec loop i =
    if i == String.length e then
      failwith "Internal error in Plexer: incorrect ANTIQUOT"
    else if i == String.length p then e.[i] == ':'
    else if p.[i] == e.[i] then loop (i + 1)
    else false
  in
  loop 0
;;

let after_colon e =
  try
    let i = String.index e ':' in
    String.sub e (i + 1) (String.length e - i - 1)
  with Not_found -> ""
;;

let check_anti_loc s kind =
  try
    let i = String.index s ':' in
    let (j, len) =
      let rec loop j =
        if j = String.length s then i, 0
        else
          match s.[j] with
            ':' -> j, j - i - 1
          | 'a'..'z' | 'A'..'Z' | '0'..'9' -> loop (j + 1)
          | _ -> i, 0
      in
      loop (i + 1)
    in
    if String.sub s (i + 1) len = kind then
      sprintf "%s:%d:%s" (String.sub s 0 i) (j - i)
        (String.sub s (j + 1) (String.length s - j - 1))
    else raise Stream.Failure
  with Not_found -> raise Stream.Failure
;;

let lex = Grammar.glexer Pcaml.gram in
lex.Token.tok_match <-
  function
    "ANTIQUOT_LOC", "" ->
      (function
         "ANTIQUOT_LOC", prm -> check_anti_loc prm ""
       | _ -> raise Stream.Failure)
  | "ANTIQUOT_LOC", "anti" ->
      (function
         "ANTIQUOT_LOC", prm -> check_anti_loc prm "anti"
       | _ -> raise Stream.Failure)
  | "ANTIQUOT_LOC", "exp" ->
      (function
         "ANTIQUOT_LOC", prm -> check_anti_loc prm "exp"
       | _ -> raise Stream.Failure)
  | "INT", "" ->
      (function
         "INT", prm -> prm
       | "ANTIQUOT_LOC", prm -> check_anti_loc prm "int"
       | _ -> raise Stream.Failure)
  | "FLOAT", "" ->
      (function
         "FLOAT", prm -> prm
       | "ANTIQUOT_LOC", prm -> check_anti_loc prm "flo"
       | _ -> raise Stream.Failure)
  | "LIDENT", "" ->
      (function
         "LIDENT", prm -> prm
       | "ANTIQUOT_LOC", prm -> check_anti_loc prm "lid"
       | _ -> raise Stream.Failure)
  | "UIDENT", "" ->
      (function
         "UIDENT", prm -> prm
       | "ANTIQUOT_LOC", prm -> check_anti_loc prm "uid"
       | _ -> raise Stream.Failure)
  | "STRING", "" ->
      (function
         "STRING", prm -> prm
       | "ANTIQUOT_LOC", prm -> check_anti_loc prm "str"
       | _ -> raise Stream.Failure)
  | ("LIST0" | "LIST1"), ("" | "SEP") ->
      (function
         "ANTIQUOT_LOC", prm -> check_anti_loc prm "list"
       | _ -> raise Stream.Failure)
  | "OPT", "" ->
      (function
         "ANTIQUOT_LOC", prm -> check_anti_loc prm "opt"
       | _ -> raise Stream.Failure)
  | "FLAG", "" ->
      (function
         "ANTIQUOT_LOC", prm -> check_anti_loc prm "flag"
       | _ -> raise Stream.Failure)
  | tok -> Token.default_match tok;;

(* reinit the entry functions to take the new tok_match into account *)
Grammar.iter_entry Grammar.reinit_entry_functions
  (Grammar.Entry.obj Pcaml.expr);;

let apply_entry e me mp =
  let f s =
    call_with Plexer.dollar_for_antiquot_loc true (Grammar.Entry.parse e)
      (Stream.of_string s)
  in
  let expr s = me (f s) in
  let patt s = mp (f s) in Quotation.ExAst (expr, patt)
;;

List.iter (fun (q, f) -> Quotation.add q f)
  ["expr", apply_entry expr_eoi Meta.e_expr Meta.p_expr;
   "patt", apply_entry patt_eoi Meta.e_patt Meta.p_patt;
   "str_item", apply_entry str_item_eoi Meta.e_str_item Meta.p_str_item;
   "sig_item", apply_entry sig_item_eoi Meta.e_sig_item Meta.p_sig_item;
   "module_expr",
   apply_entry module_expr_eoi Meta.e_module_expr Meta.p_module_expr];;