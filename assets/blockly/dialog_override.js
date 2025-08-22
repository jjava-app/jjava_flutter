(function () {
  function showPromptModal(message, defaultValue, onDone) {
    const overlay = document.createElement('div');
    overlay.style.position = 'fixed';
    overlay.style.inset = '0';
    overlay.style.background = 'rgba(0,0,0,.35)';
    overlay.style.zIndex = '9998';

    const modal = document.createElement('div');
    modal.style.position = 'fixed';
    modal.style.top = '50%';
    modal.style.left = '50%';
    modal.style.transform = 'translate(-50%, -50%)';
    modal.style.backgroundColor = '#fff';
    modal.style.border = '2px solid #5C81A6';
    modal.style.borderRadius = '10px';
    modal.style.padding = '20px';
    modal.style.zIndex = '9999';
    modal.style.boxShadow = '0 4px 12px rgba(0,0,0,0.2)';
    modal.style.fontFamily = 'Arial, sans-serif';
    modal.style.minWidth = '320px';
    modal.style.maxWidth = '90vw';

    const label = document.createElement('div');
    label.textContent = message || '';
    label.style.marginBottom = '10px';

    const input = document.createElement('input');
    input.value = defaultValue || '';
    input.style.width = '100%';
    input.style.padding = '10px';
    input.style.marginBottom = '12px';
    input.style.border = '1px solid #ccc';
    input.style.borderRadius = '6px';
    input.style.fontSize = '16px';

    const row = document.createElement('div');
    row.style.display = 'flex';
    row.style.gap = '8px';
    row.style.justifyContent = 'flex-end';

    const okButton = document.createElement('button');
    okButton.textContent = '확인';
    okButton.style.marginRight = '0';
    okButton.style.padding = '8px 14px';
    okButton.style.backgroundColor = '#5C81A6';
    okButton.style.color = '#fff';
    okButton.style.border = 'none';
    okButton.style.borderRadius = '6px';
    okButton.style.cursor = 'pointer';

    const cancelButton = document.createElement('button');
    cancelButton.textContent = '취소';
    cancelButton.style.padding = '8px 14px';
    cancelButton.style.backgroundColor = '#ccc';
    cancelButton.style.border = 'none';
    cancelButton.style.borderRadius = '6px';
    cancelButton.style.cursor = 'pointer';

    function done(val) {
      try { document.body.removeChild(modal); } catch (e) {}
      try { document.body.removeChild(overlay); } catch (e) {}
      onDone(val);
    }
    okButton.onclick = () => done(String(input.value));
    cancelButton.onclick = () => done(null);
    overlay.onclick = () => done(null);
    modal.addEventListener('keydown', e => {
      if (e.key === 'Enter') { e.preventDefault(); okButton.click(); }
      if (e.key === 'Escape') { e.preventDefault(); cancelButton.click(); }
    });

    row.appendChild(cancelButton);
    row.appendChild(okButton);
    modal.appendChild(label);
    modal.appendChild(input);
    modal.appendChild(row);
    document.body.appendChild(overlay);
    document.body.appendChild(modal);
    input.focus(); input.select();
  }

  function install() {
    if (!window.Blockly || !Blockly.dialog) { setTimeout(install, 0); return; }
    Blockly.dialog.setPrompt((message, defaultValue, callback) => {
      showPromptModal(message, defaultValue, callback);
    });
    Blockly.dialog.setConfirm((message, callback) => {
      callback(!!window.confirm(message || ''));
    });
    Blockly.dialog.setAlert((message, cb) => {
      window.alert(message || ''); if (cb) cb();
    });
  }
  install();
})();