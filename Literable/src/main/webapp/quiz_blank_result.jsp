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

    .kgw_rowQ {
        width: 100%;
        display: flex;
        flex-direction: row;
        align-items: center;
        gap: 10px;
        justify-content: flex-start;
    }

    #kgw_qnum {
        color: #6B6B6B;
        font-size: 24px;
    }

    .kgw_O,
    .kgw_X {
        width: 160px;
        color: #630C92;
    }

    .kgw_question {
        font-size: 24px;
        font-weight: 400;
        color: #000;
    }

    .kgw_line {
        width: 100%;
        color: #9a9a9a;
    }

    .kgw_answerBox {
        width: 800px; 
        height: auto;
        border-radius: 18px;
        background-color: #ECE7F5;
        display: flex;
        flex-direction: column;
        justify-content: flex-start; 
        align-items: flex-start; 
        gap: 10px;
        padding: 20px 25px; 
        box-sizing: border-box;
    }

    .kgw_Arow {
        width: 100%; 
        display: flex;
        flex-direction: row;
        justify-content: flex-start; 
        align-items: center;
        gap: 10px;
    }

    #kgw_ATtitle {
        font-size: 22px;
        font-weight: 800;
    }

    #kgw_AAnswer {
        font-size: 16px;
        font-weight: 400;
    }

    .kgw_AText {
        font-size: 1px; 
        font-weight: 400; 
        line-height: 2; 
        color: #000; 
        word-break: break-word; 
        margin-top: 10px; 
    }
    .kgw_ADetail{
    	width: 100%;
    	font-size: 16px;
    	font-weight: 400;
    	color: #000;
    	line-height: 1.5;
    }
</style>
<div id="kgw_frame">
    <div class="kgw_rowQ">
        <div id="kgw_qnum">Q1</div>
        <div class="kgw_O">❌ 오답입니다.</div>
        <div class="kgw_X">👏 정답입니다.</div>
    </div>
    <div class="kgw_question">getElementById('title');는 ID가 'title'인 요소를 선택하는 올바른 방법이다.</div>
    <hr class="kgw_line">
    <div class="kgw_answerBox">
        <div class="kgw_Arow">
            <div id="kgw_ATtitle">문제 해설</div>
            <div id="kgw_AAnswer">정답 X</div>
        </div>
        <div class="kgw_ADetail">
            id 속성을 통해서 태그를 선택하는 document 객체의 getElementById 메소드를 활용하면 되는데요. <br>
            메소드의 파라미터에 우리가 선택하고자 하는 태그의 id 속성값을 문자열로 전달해 주면 됩니다. <br>
            카멜(camel) 표기법으로 작성된 메소드 이름에서 각 알파벳의 대소문자가 헷갈리지 않도록 잘 기억해 주세요.<br>
            따라서 답은 3번 document.getElementById('title'); 입니다.
        </div>
    </div>
</div>
