<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
        #kgw_frame {
            width: 800px;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            align-items: center;
            gap: 12px;
        	margin-top: 10px;
        }
        #kgw_qnum{
            color: #6B6B6B;
            font-size: 24px;
            width: 100%;
            padding-left: 10px;
        }
        .kgw_question{
            font-size: 24px;
            font-weight: 400;
            color: #000; 
        }
        .kgw_line{
            width: 100%;
            color: #9a9a9a;
        }
        .kgw_oxBox{
		    width: 750px;
		    height: 50px;
		    border: 1px solid #D0D0D0;
		    border-radius: 10px;
		    display: flex;
		    flex-direction: row;
		    justify-content: flex-start;
		    align-items: center;
		}
        .kgw_oxText{
        	width: fit-content;
        	color: #000;
        	font-size: 24px;
        }
        .kgw_oxicon{
            width: 24px;
            padding-left: 14px;
        }
</style>    
<div id="kgw_frame">
    <div id="kgw_qnum">Q1</div>
    <div class="kgw_question">getElementById('title');는 ID가 'title'인 요소를 선택하는 올바른 방법이다.</div>
    <hr class="kgw_line">
    <div class="kgw_oxBox">
        <img class="kgw_oxicon" src="./assets/oIcon.svg">
        <div class="kgw_oxText">맞아요</div>
    </div>
    <div class="kgw_oxBox">
        <img class="kgw_oxicon" src="./assets/xIcon.svg">
        <div class="kgw_oxText">아니에요</div>
    </div>
</div>
