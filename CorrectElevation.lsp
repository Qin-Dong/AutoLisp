(defun c:zzElevCorrecting ()		;������:zzElevCorrecting�����غ������������롣
  (setq elevDiff (getreal "������ȸ��ߵĸ̲߳�ֵ: "))
  (setq elevDist (getint "������ȸ߾�: "))
  (prompt "\n <<��ѡ�����ĸ̵߳ĵȸ���>>")
  (setq ss (ssget))			;ȡ��ѡ�񼯡�
  (setq	n 0
	Cnt 0
  )					;ѡ�񼯵���ʼֵn��0
  (repeat (sslength ss)			;����ѡ�񼯵Ķ��������
    (setq en (ssname ss n))		;��������ֵȡ��ѡ���е�ͼԪ����
    (setq endata (entget en))		;ȡ�ö���������б�
    (setq oldColor (cdr (assoc 62 endata)))
    (setq entType (cdr (assoc 0 endata)))
    (setq oldLayer (cdr (assoc 8 endata)))
    (if	(and (/= oldLayer "1-����-�ȸ���-����") ;�ȸ���Ϊ������ʱ�Ĵ���
	     (= entType "LWPOLYLINE")
	)
      (progn
	(setq elePl (cdr (assoc 38 endata)))
					;38��ʾ�߶εĸ߳�,elePl:�����߱��
	(setq elePlProp (assoc 38 endata)) ;elePlProp:�����߱��ԭ����
	(setq eleRt (+ elePl elevDiff))	;��������ȷ�ĸ߳�ֵ�����߼��ϸ߲�
	(setq eleRtProp (cons 38 eleRt));eleRtProp:���ϸ߲��������ȷ�ж��徭������Ա�

	(if (= (rem eleRt (* 5 elevDist)) 0)
	  (setq newColor 1)		;�����ߺ�ɫ
	  (setq newColor 2)		;�����߻�ɫ
	)
	(setq endata (subst eleRtProp elePlProp endata))
					;���µ����Ա���ľɵ����Ա�
					;�����Ϊ�µĹ�ϵ����
					;(setq oldLayer (assoc 8 endata))	;�ҵ�ԭͼ��
	(setq newLayer (cons 8 "1-����-�ȸ���-����")) ;�����µ�ͼ��
	(setq endata (subst newLayer (cons 8 oldLayer) endata))
					;�Ѹ��˸߳�ֵ�ĵȸ��߷����µ�ͼ���С�
	(setq
	  endata (subst (cons 62 newColor) (cons 62 oldColor) endata)
	)
	(entmod endata)			;�����µ������б���������Ļ�ϵĶ���
	(setq Cnt (1+ Cnt))
      )					;progn
    )					;if

    (if	(and (/= oldLayer "1-����-�ȸ���-����")
	     (= entType "POLYLINE")	;���ȸ���Ϊ��ά�����ߵĴ���
	)
      (progn
	(setq elePl (last (assoc 10 endata)))
	(print elePl)			;38��ʾ�߶εĸ߳�,elePl:�����߱��
	(setq elePlProp (assoc 10 endata)) ;elePlProp:�����߱��ԭ����
	(setq eleRt (+ elePl elevDiff))	;��������ȷ�ĸ߳�ֵ�����߼��ϸ߲�
	(setq eleRtProp (list 10 0.0 0.0 eleRt))
					;eleRtProp:���ϸ߲��������ȷ�ж��徭������Ա�

	(if (= (rem eleRt (* 5 elevDist)) 0)
	  (setq newColor 1)		;�����ߺ�ɫ
	  (setq newColor 2)		;�����߻�ɫ
	)
	(setq endata (subst eleRtProp elePlProp endata))
					;���µ����Ա���ľɵ����Ա�
					;�����Ϊ�µĹ�ϵ����
					;(setq oldLayer (assoc 8 endata))	;�ҵ�ԭͼ��
	(setq newLayer (cons 8 "1-����-�ȸ���-����")) ;�����µ�ͼ��
	(setq endata (subst newLayer (cons 8 oldLayer) endata))
					;�Ѹ��˸߳�ֵ�ĵȸ��߷����µ�ͼ���С�
	(setq
	  endata (subst (cons 62 newColor) (cons 62 oldColor) endata)
	)
	(entmod endata)			;�����µ������б���������Ļ�ϵĶ���
	(setq Cnt (1+ Cnt))
      )					;progn
    )					;if


    (setq n (1+ n))
  )
  (princ
    (strcat "\n ����< " (itoa Cnt) " >���ȸ��߸�����ϣ�")
  )
  (prompt "���ٸ����ȸ��߸̡߳�(C)QinDong 2019.07.31 ����IX��"
  )
  (prin1)
)