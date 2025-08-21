(function(){
  const css = `
  /* 툴박스 컨테이너(좌측 패널 느낌) */
  .blocklyToolboxDiv {
    background: #0b1220 !important;
    color: #fff !important;
    border-right: 1px solid #1f2937;
    width: 220px;             /* 고정폭(내용에 따라 넓혀지면 삭제) */
  }
  /* 카테고리 라벨(좌측 트리) */
  .blocklyTreeLabel { color:#e5e7eb !important; font-size: 13px; }
  .blocklyTreeRow { height: 28px; }
  .blocklyTreeSelected .blocklyTreeRow { background:#1f2937 !important; }
  /* 플라이아웃 배경 */
  .blocklyFlyoutBackground { fill:#0f172a !important; fill-opacity:1 !important; }
  /* 플라이아웃 라벨(텍스트) */
  .blocklyFlyoutLabelText { fill:#9ca3af !important; font-size:12px; }
  `;
  const style = document.createElement('style');
  style.textContent = css;
  document.head.appendChild(style);
})();