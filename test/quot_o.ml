<:expr< $e1$ . $e2$ >>;;
<:expr< $anti:e$ >>;;
<:expr< $e1$ $e2$ >>;;
<:expr< $e1$ .( $e2$ ) >>;;
<:expr< [| $list:le$ |] >>;;
<:expr< [| $_list:le$ |] >>;;
<:expr< assert $e$ >>;;
<:expr< $e1$ <- $e2$ >>;;
<:expr< $e$ .{ $list:le$ } >>;;
<:expr< $e$ .{ $_list:le$ } >>;;
<:expr< $chr:s$ >>;;
<:expr< $_chr:s$ >>;;
<:expr< ($e$ : $t1$ :> $t2$) >>;;
<:expr< ($e$ :> $t2$) >>;;
<:expr< $flo:s$ >>;;
<:expr< $_flo:s$ >>;;
<:expr< for $lid:s$ = $e1$ to $e2$ do $list:le$ done >>;;
<:expr< for $_lid:s$ = $e1$ to $e2$ do $_list:le$ done >>;;
<:expr< for $lid:s$ = $e1$ downto $e2$ do $list:le$ done >>;;
<:expr< for $_lid:s$ = $e1$ downto $e2$ do $_list:le$ done >>;;
<:expr< for $lid:s$ = $e1$ $to:b$ $e2$ do $list:le$ done >>;;
<:expr< for $_lid:s$ = $e1$ $_to:b$ $e2$ do $_list:le$ done >>;;
<:expr< function $list:lpwe$ >>;;
<:expr< function $_list:lpwe$ >>;;
<:expr< if $e1$ then $e2$ else $e3$ >>;;
<:expr< $int:s$ >>;;
<:expr< $_int:s$ >>;;
<:expr< $int32:s$ >>;;
<:expr< $_int32:s$ >>;;
<:expr< $int64:s$ >>;;
<:expr< $_int64:s$ >>;;
<:expr< $nativeint:s$ >>;;
<:expr< $_nativeint:s$ >>;;
<:expr< ~$s$ >>;;
<:expr< ~$_:s$ >>;;
<:expr< ~$s$: $e$ >>;;
<:expr< ~$_:s$: $e$ >>;;
<:expr< lazy $e$ >>;;
<:expr< let $list:lpe$ in $e$ >>;;
<:expr< let $_list:lpe$ in $e$ >>;;
<:expr< let rec $list:lpe$ in $e$ >>;;
<:expr< let rec $_list:lpe$ in $e$ >>;;
<:expr< let $flag:b$ $list:lpe$ in $e$ >>;;
<:expr< let $_flag:b$ $_list:lpe$ in $e$ >>;;
<:expr< $lid:s$ >>;;
<:expr< $_lid:s$ >>;;
<:expr< let module $uid:s$ = $me$ in $e$ >>;;
<:expr< let module $_uid:s$ = $me$ in $e$ >>;;
<:expr< match $e$ with $list:lpwe$ >>;;
<:expr< match $e$ with $_list:lpwe$ >>;;
<:expr< new $list:ls$ >>;;
<:expr< new $_list:ls$ >>;;
<:expr< object $opt:op$ $list:lcstri$ end >>;;
<:expr< object $_opt:op$ $_list:lcstri$ end >>;;
<:expr< ?$s$ >>;;
<:expr< ?$_:s$ >>;;
<:expr< ?$s$: $e$ >>;;
<:expr< ?$_:s$: $e$ >>;;
<:expr< {< $list:lse$ >} >>;;
<:expr< {< $_list:lse$ >} >>;;
<:expr< { $list:lpe$ } >>;;
<:expr< { $_list:lpe$ } >>;;
<:expr< { ($e$) with $list:lpe$ } >>;;
<:expr< { ($e$) with $_list:lpe$ } >>;;
<:expr< $list:le$ >>;;
<:expr< $_list:le$ >>;;
<:expr< $e$ # $lid:s$ >>;;
<:expr< $e$ # $_lid:s$ >>;;
<:expr< $e1$ .[ $e2$ ] >>;;
<:expr< $str:s$ >>;;
<:expr< $_str:s$ >>;;
<:expr< try $e$ with $list:lpwe$ >>;;
<:expr< try $e$ with $_list:lpwe$ >>;;
<:expr< ($list:le$) >>;;
<:expr< ($_list:le$) >>;;
<:expr< ($e$ : $t$) >>;;
<:expr< $uid:s$ >>;;
<:expr< $_uid:s$ >>;;
<:expr< `$s$ >>;;
<:expr< `$_:s$ >>;;
<:expr< while $e$ do $list:le$ done >>;;
<:expr< while $e$ do $_list:le$ done >>;;
<:patt< $p1$ . $p2$ >>;;
MLast.PaAli (loc, p1, p2);;
<:patt< $anti:p$ >>;;
<:patt< _ >>;;
<:patt< $p1$ $p2$ >>;;
<:patt< [| $list:lp$ |] >>;;
<:patt< [| $_list:lp$ |] >>;;
<:patt< $chr:s$ >>;;
<:patt< $_chr:s$ >>;;
<:patt< $int:s$ >>;;
<:patt< $_int:s$ >>;;
<:patt< $int32:s$ >>;;
<:patt< $_int32:s$ >>;;
<:patt< $int64:s$ >>;;
<:patt< $_int64:s$ >>;;
<:patt< $nativeint:s$ >>;;
<:patt< $_nativeint:s$ >>;;
<:patt< $flo:s$ >>;;
<:patt< $_flo:s$ >>;;
<:patt< ~$s$ >>;;
<:patt< ~$_:s$ >>;;
<:patt< ~$s$: $p$ >>;;
<:patt< ~$_:s$: $p$ >>;;
<:patt< $lid:s$ >>;;
<:patt< $_lid:s$ >>;;
<:patt< ?$s$ >>;;
<:patt< ?$_:s$ >>;;
<:patt< ?$s$: ($p$) >>;;
<:patt< ?$_:s$: ($p$) >>;;
<:patt< ?$s$: ($p$ = $e$) >>;;
<:patt< ?$_:s$: ($p$ = $e$) >>;;
<:patt< $p1$ | $p2$ >>;;
<:patt< $p1$ .. $p2$ >>;;
<:patt< { $list:lpp$ } >>;;
<:patt< { $_list:lpp$ } >>;;
<:patt< $str:s$ >>;;
<:patt< $_str:s$ >>;;
<:patt< ($list:lp$) >>;;
<:patt< ($_list:lp$) >>;;
<:patt< ($p$ : $t$) >>;;
<:patt< # $list:ls$ >>;;
<:patt< # $_list:ls$ >>;;
<:patt< $uid:s$ >>;;
<:patt< $_uid:s$ >>;;
<:patt< ` $s$ >>;;
<:patt< ` $_:s$ >>;;
<:ctyp< $t1$ . $t2$ >>;;
MLast.TyAli (loc, t1, t2);;
<:ctyp< _ >>;;
<:ctyp< $t2$ $t1$ >>;;
<:ctyp< $t1$ -> $t2$ >>;;
<:ctyp< # $list:ls$ >>;;
<:ctyp< # $_list:ls$ >>;;
<:ctyp< $lid:s$ : $t$ >>;;
<:ctyp< $_lid:s$: $t$ >>;;
<:ctyp< $lid:s$ >>;;
<:ctyp< $_lid:s$ >>;;
MLast.TyMan (loc, t1, t2);;
<:ctyp< < $list:lst$ > >>;;
<:ctyp< < $_list:lst$ > >>;;
<:ctyp< < $list:lst$ .. > >>;;
<:ctyp< < $_list:lst$ .. > >>;;
<:ctyp< < $list:lst$ $flag:b$ > >>;;
<:ctyp< < $_list:lst$ $_flag:b$ > >>;;
<:ctyp< ?$s$: $t$ >>;;
<:ctyp< ?$_:s$: $t$ >>;;
MLast.TyPol (loc, Ploc.VaVal ls, t);;
MLast.TyPol (loc, ls, t);;
<:ctyp< ' $s$ >>;;
<:ctyp< ' $_:s$ >>;;
MLast.TyRec (loc, Ploc.VaVal llsbt);;
MLast.TyRec (loc, llsbt);;
MLast.TySum (loc, Ploc.VaVal llslt);;
MLast.TySum (loc, llslt);;
MLast.TyTup (loc, Ploc.VaVal lt);;
MLast.TyTup (loc, lt);;
<:ctyp< $uid:s$ >>;;
<:ctyp< $_uid:s$ >>;;
<:ctyp< [ $list:lpv$ ] >>;;
<:ctyp< [ $_list:lpv$ ] >>;;
<:ctyp< [ > $list:lpv$ ] >>;;
<:ctyp< [ > $_list:lpv$ ] >>;;
<:ctyp< [< $list:lpv$ ] >>;;
<:ctyp< [< $_list:lpv$ ] >>;;
<:ctyp< [< $list:lpv$ > $list:ls$ ] >>;;
<:ctyp< [< $_list:lpv$ > $_list:ls$ ] >>;;
<:str_item< class $list:lcd$ >>;;
<:str_item< class $_list:lcd$ >>;;
<:str_item< class type $list:lctd$ >>;;
<:str_item< class type $_list:lctd$ >>;;
MLast.StDcl (loc, Ploc.VaVal lstri);;
MLast.StDcl (loc, lstri);;
MLast.StDir (loc, Ploc.VaVal s, Ploc.VaVal None);;
MLast.StDir (loc, s, Ploc.VaVal None);;
MLast.StDir (loc, Ploc.VaVal s, Ploc.VaVal (Some e));;
MLast.StDir (loc, s, Ploc.VaVal (Some e));;
MLast.StDir (loc, Ploc.VaVal s, Ploc.VaVal oe);;
MLast.StDir (loc, s, oe);;
<:str_item< exception $s$ of $list:lt$ >>;;
<:str_item< exception $_:s$ of $_list:lt$ >>;;
<:str_item< exception $s$ = $list:ls$ >>;;
<:str_item< exception $_:s$ = $_list:ls$ >>;;
<:str_item< exception $s$ of $list:lt$ = $list:ls$ >>;;
<:str_item< exception $_:s$ of $_list:lt$ = $_list:ls$ >>;;
<:str_item< $exp:e$ >>;;
<:str_item< external $s$ : $t$ = $list:ls$ >>;;
<:str_item< external $_:s$ : $t$ = $_list:ls$ >>;;
<:str_item< include $me$ >>;;
<:str_item< module $list:lsme$ >>;;
<:str_item< module $_list:lsme$ >>;;
<:str_item< module rec $list:lsme$ >>;;
<:str_item< module rec $_list:lsme$ >>;;
<:str_item< module $flag:b$ $list:lsme$ >>;;
<:str_item< module $_flag:b$ $_list:lsme$ >>;;
<:str_item< module type $s$ = $mt$ >>;;
<:str_item< module type $_:s$ = $mt$ >>;;
<:str_item< open $list:ls$ >>;;
<:str_item< open $_list:ls$ >>;;
<:str_item< type $list:ltd$ >>;;
<:str_item< type $_list:ltd$ >>;;
<:str_item< let $list:lpe$ >>;;
<:str_item< let $_list:lpe$ >>;;
<:str_item< let rec $list:lpe$ >>;;
<:str_item< let rec $_list:lpe$ >>;;
<:str_item< let $flag:b$ $list:lpe$ >>;;
<:str_item< let $_flag:b$ $_list:lpe$ >>;;
<:sig_item< class $list:lcd$ >>;;
<:sig_item< class $_list:lcd$ >>;;
<:sig_item< class type $list:lct$ >>;;
<:sig_item< class type $_list:lct$ >>;;
MLast.SgDcl (loc, Ploc.VaVal lsigi);;
MLast.SgDcl (loc, lsigi);;
MLast.SgDir (loc, Ploc.VaVal s, Ploc.VaVal None);;
MLast.SgDir (loc, s, Ploc.VaVal None);;
MLast.SgDir (loc, Ploc.VaVal s, Ploc.VaVal (Some e));;
MLast.SgDir (loc, s, Ploc.VaVal (Some e));;
MLast.SgDir (loc, Ploc.VaVal s, Ploc.VaVal oe);;
MLast.SgDir (loc, s, oe);;
<:sig_item< exception $s$ >>;;
<:sig_item< exception $_:s$ >>;;
<:sig_item< exception $s$ of $list:lt$ >>;;
<:sig_item< exception $_:s$ of $_list:lt$ >>;;
<:sig_item< external $s$ : $t$ = $list:ls$ >>;;
<:sig_item< external $_:s$ : $t$ = $_list:ls$ >>;;
<:sig_item< include $me$ >>;;
<:sig_item< module $list:lsmt$ >>;;
<:sig_item< module $_list:lsmt$ >>;;
<:sig_item< module rec $list:lsmt$ >>;;
<:sig_item< module rec $_list:lsmt$ >>;;
<:sig_item< module $flag:b$ $list:lsmt$ >>;;
<:sig_item< module $_flag:b$ $_list:lsmt$ >>;;
<:sig_item< module type $s$ = $mt$ >>;;
<:sig_item< module type $_:s$ = $mt$ >>;;
<:sig_item< open $list:ls$ >>;;
<:sig_item< open $_list:ls$ >>;;
<:sig_item< type $list:ltd$ >>;;
<:sig_item< type $_list:ltd$ >>;;
<:sig_item< val $s$ : $t$ >>;;
<:sig_item< val $_:s$ : $t$ >>;;
MLast.MeAcc (loc, me1, me2);;
<:module_expr< $me1$ $me2$ >>;;
<:module_expr< functor ($s$ : $mt$) -> $me$ >>;;
<:module_expr< functor ($_:s$ : $mt$) -> $me$ >>;;
<:module_expr< struct $list:lstri$ end >>;;
<:module_expr< struct $_list:lstri$ end >>;;
<:module_expr< ($me$ : $mt$) >>;;
<:module_expr< $uid:s$ >>;;
<:module_expr< $_uid:s$ >>;;
MLast.MtAcc(loc, mt1, mt2);;
MLast.MtApp(loc, mt1, mt2);;
<:module_type< functor ($s$ : $mt1$) -> $mt2$ >>;;
<:module_type< functor ($_:s$ : $mt1$) -> $mt2$ >>;;
<:module_type< $lid:s$ >>;;
<:module_type< $_lid:s$ >>;;
MLast.MtQuo (loc, Ploc.VaVal s);;
MLast.MtQuo (loc, s);;
<:module_type< sig $list:lsigi$ end >>;;
<:module_type< sig $_list:lsigi$ end >>;;
<:module_type< $uid:s$ >>;;
<:module_type< $_uid:s$ >>;;
<:module_type< $mt$ with $list:lwc$ >>;;
<:module_type< $mt$ with $_list:lwc$ >>;;
<:with_constr< type $list:ltv$ $s$ = $t$ >>;;
<:with_constr< type $_list:ltv$ $_:s$ = $t$ >>;;
<:with_constr< type $list:ltv$ $s$ = private $t$ >>;;
<:with_constr< type $_list:ltv$ $_:s$ = private $t$ >>;;
<:with_constr< type $list:ltv$ $s$ = $flag:b$ $t$ >>;;
<:with_constr< type $_list:ltv$ $_:s$ = $_flag:b$ $t$ >>;;
<:with_constr< module $ls$ = $me$ >>;;
<:with_constr< module $_:ls$ = $me$ >>;;
<:class_expr< $ce$ $e$ >>;;
MLast.CeCon (loc, Ploc.VaVal ls, Ploc.VaVal lt);;
MLast.CeCon (loc, ls, lt);;
<:class_expr< fun $p$ -> $ce$ >>;;
<:class_expr< let $flag:b$ $list:lpe$ in $ce$ >>;;
<:class_expr< let $_flag:b$ $_list:lpe$ in $ce$ >>;;
<:class_expr< object $opt:op$ $list:lcstri$ end >>;;
<:class_expr< object $_opt:op$ $_list:lcstri$ end >>;;
MLast.CeTyc (loc, ce, ct);;
MLast.CtCon (loc, Ploc.VaVal ls, Ploc.VaVal lt);;
MLast.CtCon (loc, ls, lt);;
MLast.CtFun (loc, t, ct);;
<:class_type< object $list:lcsigi$ end >>;;
<:class_type< object $_list:lcsigi$ end >>;;
<:class_type< object ($t$) $list:lcsigi$ end >>;;
<:class_type< object ($t$) $_list:lcsigi$ end >>;;
<:class_type< object $opt:ot$ $list:lcsigi$ end >>;;
<:class_type< object $_opt:ot$ $_list:lcsigi$ end >>;;
<:class_str_item< constraint $t1$ = $t2$ >>;;
MLast.CrDcl (loc, Ploc.VaVal lcstri);;
MLast.CrDcl (loc, lcstri);;
<:class_str_item< inherit $ce$ >>;;
<:class_str_item< inherit $ce$ $_opt:os$ >>;;
<:class_str_item< initializer $e$ >>;;
<:class_str_item< method $s$ = $e$ >>;;
<:class_str_item< method $_:s$ = $e$ >>;;
<:class_str_item< method $s$ : $t$ = $e$ >>;;
<:class_str_item< method $_:s$ : $t$ = $e$ >>;;
<:class_str_item< method private $s$ = $e$ >>;;
<:class_str_item< method private $_:s$ = $e$ >>;;
<:class_str_item< method private $s$ : $t$ = $e$ >>;;
<:class_str_item< method private $_:s$ : $t$ = $e$ >>;;
MLast.CrMth (loc, Ploc.VaVal s, Ploc.VaVal b, Ploc.VaVal false, e, Ploc.VaVal ot);;
MLast.CrMth (loc, s, b, Ploc.VaVal false, e, ot);;
<:class_str_item< val $s$ = $e$ >>;;
<:class_str_item< val $_:s$ = $e$ >>;;
<:class_str_item< val mutable $s$ = $e$ >>;;
<:class_str_item< val mutable $_:s$ = $e$ >>;;
<:class_str_item< val $flag:b$ $s$ = $e$ >>;;
<:class_str_item< val $_flag:b$ $_:s$ = $e$ >>;;
<:class_str_item< method virtual $s$ : $t$ >>;;
<:class_str_item< method virtual $_:s$ : $t$ >>;;
<:class_str_item< method virtual private $s$ : $t$ >>;;
<:class_str_item< method virtual private $_:s$ : $t$ >>;;
MLast.CrVir (loc, Ploc.VaVal s, Ploc.VaVal b, t);;
MLast.CrVir (loc, s, b, t);;
<:class_sig_item< constraint $t1$ = $t2$ >>;;
MLast.CgDcl (loc, Ploc.VaVal lcsigi);;
MLast.CgDcl (loc, lcsigi);;
MLast.CgInh (loc, ct);;
<:class_sig_item< method $s$ : $t$ >>;;
<:class_sig_item< method $_:s$ : $t$ >>;;
<:class_sig_item< method private $s$ : $t$ >>;;
<:class_sig_item< method private $_:s$ : $t$ >>;;
MLast.CgMth (loc, Ploc.VaVal s, Ploc.VaVal b, t);;
MLast.CgMth (loc, s, b, t);;
<:class_sig_item< val $s$ : $t$ >>;;
<:class_sig_item< val $_:s$ : $t$ >>;;
<:class_sig_item< val mutable $s$ : $t$ >>;;
<:class_sig_item< val mutable $_:s$ : $t$ >>;;
<:class_sig_item< val $flag:b$ $s$ : $t$ >>;;
<:class_sig_item< val $_flag:b$ $_:s$ : $t$ >>;;
<:class_sig_item< method virtual $s$ : $t$ >>;;
<:class_sig_item< method virtual $_:s$ : $t$ >>;;
<:class_sig_item< method virtual private $s$ : $t$ >>;;
<:class_sig_item< method virtual private $_:s$ : $t$ >>;;
MLast.CgVir (loc, Ploc.VaVal s, Ploc.VaVal b, t);;
MLast.CgVir (loc, s, b, t);;
<:poly_variant< ` $s$ >>;;
<:poly_variant< ` $_:s$ >>;;
<:poly_variant< ` $s$ of $list:lt$ >>;;
<:poly_variant< ` $_:s$ of $_list:lt$ >>;;
<:poly_variant< ` $s$ of & $list:lt$ >>;;
<:poly_variant< ` $_:s$ of & $_list:lt$ >>;;
<:poly_variant< ` $s$ of $flag:b$ $list:lt$ >>;;
<:poly_variant< ` $_:s$ of $_flag:b$ $_list:lt$ >>;;
<:poly_variant< $t$ >>;;
