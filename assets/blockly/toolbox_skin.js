(function(){
  const css = `
  /* 툴박스 컨테이너 */
  .blocklyScrollbarHorizontal,
  .blocklyScrollbarVertical {
    opacity: 0 !important;
  }

  .blocklyScrollbarKnob {
    opacity: 0 !important;
  }

  .scroll-container::-webkit-scrollbar {
    display: none;
  }

  .blocklyZoomOut,
  .blocklyZoomIn {
    display: none;
  }

  .blocklyZoom.blocklyZoomReset {
    transform: translate(0, 0);
  }

  /* 툴박스 영역역 */

  .blocklyToolbox {
    display: flex;
    flex-direction: row;
    flex-wrap: nowrap !important;
    overflow-x: scroll !important;
    overflow-y: hidden !important;
    align-items: center;
    background: transparent;
    white-space: nowrap;
    -webkit-overflow-scrolling: touch;
    scroll-behavior: smooth;
    padding: 8px;
  }

  /* 블럭 카테고리 리스트 */

  .blocklyToolboxCategoryContainer {
    margin: 0px !important;
    padding 0 16px;
  }

  .blocklyToolboxCategoryGroup {
    flex-wrap: nowrap;
    gap: 8px;
  }

  .blocklyToolboxCategory {
    display: inline-block;
    margin-bottom: 0px;
    border-width: 2px !important;
    border-style: solid !important;
    border-color: transparent !important;
    box-sizing: border-box;
  }

  .blocklyToolboxCategoryLabel {
    font-family: "Roboto", sans-serif;
    font-size: 16px;
    line-height: 1.2;
  }

  /* 블럭 리스트 */

  .blocklyFlyout,
  .blocklyToolboxFlyout {
    height: 133px !important;
    bottom: 32px;
    transform: translateY(0) !important;
  }

  .blocklyFlyoutBackground {
    height: 133px !important;
    background-color: transparent;
    fill: transparent !important;
  }
  `;
  const style = document.createElement('style');
  style.textContent = css;
  document.head.appendChild(style);
})();