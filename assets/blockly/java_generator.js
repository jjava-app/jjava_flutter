(function () {
  function installJavaGenerator() {
    try {
      if (!window.Blockly || !Blockly.Generator || !Blockly.Names) return false;
      if (Blockly.Java) { window.__JAVA_GEN_OK__ = true; return true; }

      Blockly.Java = new Blockly.Generator('Java');

      Blockly.Java.ORDER_ATOMIC = 0;
      Blockly.Java.ORDER_UNARY = 1;
      Blockly.Java.ORDER_MULTIPLICATIVE = 2;
      Blockly.Java.ORDER_ADDITIVE = 3;
      Blockly.Java.ORDER_RELATIONAL = 4;
      Blockly.Java.ORDER_LOGICAL_AND = 5;
      Blockly.Java.ORDER_LOGICAL_OR = 6;

      Blockly.Java.RESERVED_WORDS_ =
        'abstract,assert,boolean,break,byte,case,catch,char,class,const,continue,'+
        'default,do,double,else,enum,extends,false,final,finally,float,for,goto,'+
        'if,implements,import,instanceof,int,interface,long,native,new,null,'+
        'package,private,protected,public,return,short,static,strictfp,super,'+
        'switch,synchronized,this,throw,throws,transient,true,try,void,volatile,while';

      Blockly.Java.init = function(workspace){
        if (!Blockly.Java.nameDB_) {
          Blockly.Java.nameDB_ = new Blockly.Names(Blockly.Java.RESERVED_WORDS_);
        } else {
          Blockly.Java.nameDB_.reset();
        }
        if (workspace && workspace.getVariableMap) {
          Blockly.Java.nameDB_.setVariableMap(workspace.getVariableMap());
        }
        Blockly.Java._ws = workspace;
        Blockly.Java.definitions_ = Object.create(null);
      };

      Blockly.Java.finish = function(code){
        const imports = Object.values(Blockly.Java.definitions_).join('\n');
        let decl = '';
        if (Blockly.Java._ws && Blockly.Java._ws.getAllVariables) {
          decl = Blockly.Java._ws.getAllVariables().map(v=>{
            const safe = Blockly.Java.nameDB_.getName(v.getId(), Blockly.Names.NameType.VARIABLE);
            return `double ${safe} = 0;`;
          }).join('\n');
        }
        const body = `${decl}${decl ? '\n\n' : ''}${code}`;
        return `${imports}
public class Main {
  public static void main(String[] args) {
${body.split('\n').map(l => (l ? '    ' + l : '')).join('\n')}
  }
}
`.trim()+'\n';
      };

      // SAFE blockToCode
      const _orig = Blockly.Java.blockToCode.bind(Blockly.Java);
      Blockly.Java.blockToCode = function(block){
        try{
          const fn = this[block.type];
          if (typeof fn !== 'function') {
            if (block && block.outputConnection) {
              return [`(0/*UNMAPPED:${block.type}*/)` , this.ORDER_ATOMIC];
            }
            return `/* UNMAPPED:${block.type} */\n`;
          }
          return fn.call(this, block);
        }catch(e){
          if (block && block.outputConnection) {
            return [`(0/*ERR:${block.type}:${String(e)}*/)` , this.ORDER_ATOMIC];
          }
          return `/* ERR:${block.type}:${String(e)} */\n`;
        }
      };

      Blockly.Java.scrubNakedValue = function(line){ return line + ';\n'; };

      function varName(block){
        const id = block.getFieldValue('VAR');
        if (id && Blockly.Java.nameDB_) {
          return Blockly.Java.nameDB_.getName(id, Blockly.Names.NameType.VARIABLE);
        }
        const f = block.getField && block.getField('VAR');
        return (f && f.getText) ? f.getText() : 'v';
      }

      // 값 블록
      Blockly.Java['math_number'] = function(block){
        const num = String(block.getFieldValue('NUM') ?? '0');
        return [num, Blockly.Java.ORDER_ATOMIC];
      };
      Blockly.Java['math_arithmetic'] = function(block){
        const OP = block.getFieldValue('OP');
        const map = { ADD: '+', MINUS: '-', MULTIPLY: '*', DIVIDE: '/' };
        const A = Blockly.Java.valueToCode(block, 'A', Blockly.Java.ORDER_ADDITIVE) || '0';
        const B = Blockly.Java.valueToCode(block, 'B', Blockly.Java.ORDER_ADDITIVE) || '0';
        return [`(${A} ${map[OP]||'+'} ${B})`, Blockly.Java.ORDER_ADDITIVE];
      };
      Blockly.Java['logic_compare'] = function(block){
        const map = { EQ:'==', NEQ:'!=', LT:'<', LTE:'<=', GT:'>', GTE:'>=' };
        const A = Blockly.Java.valueToCode(block, 'A', Blockly.Java.ORDER_RELATIONAL) || '0';
        const B = Blockly.Java.valueToCode(block, 'B', Blockly.Java.ORDER_RELATIONAL) || '0';
        const op = map[block.getFieldValue('OP')] || '==';
        return [`(${A} ${op} ${B})`, Blockly.Java.ORDER_RELATIONAL];
      };
      Blockly.Java['logic_operation'] = function(block){
        const OP = block.getFieldValue('OP');
        const A = Blockly.Java.valueToCode(block, 'A', Blockly.Java.ORDER_LOGICAL_AND) || 'false';
        const B = Blockly.Java.valueToCode(block, 'B', Blockly.Java.ORDER_LOGICAL_AND) || 'false';
        const op = (OP==='AND')?'&&':'||';
        const order = (OP==='AND')?Blockly.Java.ORDER_LOGICAL_AND:Blockly.Java.ORDER_LOGICAL_OR;
        return [`(${A} ${op} ${B})`, order];
      };
      Blockly.Java['logic_boolean'] = function(block){
        const val = block.getFieldValue('BOOL') === 'TRUE' ? 'true' : 'false';
        return [val, Blockly.Java.ORDER_ATOMIC];
      };
      Blockly.Java['text'] = function(block){
        const t = block.getFieldValue('TEXT') || '';
        const esc = t.replace(/\\/g,'\\\\').replace(/"/g,'\\"').replace(/\n/g,'\\n');
        return [`"${esc}"`, Blockly.Java.ORDER_ATOMIC];
      };

      // 변수/문장
      Blockly.Java['variables_get'] = function(block){
        return [varName(block), Blockly.Java.ORDER_ATOMIC];
      };
      Blockly.Java['variables_set'] = function(block){
        const name = varName(block);
        const val = Blockly.Java.valueToCode(block, 'VALUE', Blockly.Java.ORDER_ATOMIC) || '0';
        return `${name} = ${val};\n`;
      };
      Blockly.Java['variables_get_dynamic'] = Blockly.Java['variables_get'];
      Blockly.Java['variables_set_dynamic'] = Blockly.Java['variables_set'];

      Blockly.Java['math_change'] = function(block){
        const name = varName(block);
        const delta = Blockly.Java.valueToCode(block, 'DELTA', Blockly.Java.ORDER_ADDITIVE) || '0';
        return `${name} += ${delta};\n`;
      };

      Blockly.Java['text_print'] = function(block){
        const msg = Blockly.Java.valueToCode(block, 'TEXT', Blockly.Java.ORDER_ATOMIC) || '""';
        return `System.out.println(${msg});\n`;
      };

      // 제어
      Blockly.Java['controls_if'] = function(block){
        let n=0, code='';
        do{
          const cond = Blockly.Java.valueToCode(block, 'IF'+n, Blockly.Java.ORDER_ATOMIC) || 'false';
          const branch = Blockly.Java.statementToCode(block, 'DO'+n);
          code += (n===0 ? `if (${cond}) {\n` : `else if (${cond}) {\n`);
          code += branch;
          code += `}\n`;
          n++;
        }while(block.getInput('IF'+n));
        if (block.getInput('ELSE')) {
          const branch = Blockly.Java.statementToCode(block, 'ELSE');
          code += `else {\n${branch}}\n`;
        }
        return code;
      };
      Blockly.Java['controls_whileUntil'] = function(block){
        const isUntil = block.getFieldValue('MODE') === 'UNTIL';
        let cond = Blockly.Java.valueToCode(block, 'BOOL', Blockly.Java.ORDER_ATOMIC) || 'false';
        if (isUntil) cond = `!(${cond})`;
        const branch = Blockly.Java.statementToCode(block, 'DO');
        return `while (${cond}) {\n${branch}}\n`;
      };
      Blockly.Java['controls_repeat_ext'] = function(block){
        const times = Blockly.Java.valueToCode(block, 'TIMES', Blockly.Java.ORDER_ATOMIC) || '0';
        const branch = Blockly.Java.statementToCode(block, 'DO');
        return `for (int i = 0; i < (int)(${times}); i++) {\n${branch}}\n`;
      };
      Blockly.Java['controls_for'] = function(block){
        const name = varName(block);
        const from = Blockly.Java.valueToCode(block, 'FROM', Blockly.Java.ORDER_ADDITIVE) || '0';
        const to   = Blockly.Java.valueToCode(block, 'TO',   Blockly.Java.ORDER_ADDITIVE) || '0';
        const by   = Blockly.Java.valueToCode(block, 'BY',   Blockly.Java.ORDER_ADDITIVE) || '1';
        const body = Blockly.Java.statementToCode(block, 'DO');
        return `for (int ${name} = (int)(${from}); ${name} <= (int)(${to}); ${name} += (int)(${by})) {\n${body}}\n`;
      };

      // 실행(Flutter 채널 사용)
      window.BlocklyJavaSend = function(){
        try{
          var ws = Blockly.getMainWorkspace();
          Blockly.Java.init(ws);
          var code = '';
          var tops = ws.getTopBlocks(false);
          for (var i=0;i<tops.length;i++){
            var out = Blockly.Java.blockToCode(tops[i]);
            if (Array.isArray(out)) code += Blockly.Java.scrubNakedValue(out[0]);
            else if (typeof out === 'string') code += out;
          }
          code = Blockly.Java.finish(code);
          if (window.JavaOut && typeof window.JavaOut.postMessage === 'function') {
            window.JavaOut.postMessage(code);
          } else {
            console.log('[JavaOut missing]\\n' + code);
          }
        }catch(e){ console.error('[BlocklyJavaSend error]', e); }
      };

      window.__JAVA_GEN_OK__ = true;
      return true;
    } catch (e) {
      console.error('[Java generator install error]', e);
      return false;
    }
  }

  if (!installJavaGenerator()) {
    let tries = 0, max = 200;
    const h = setInterval(function(){
      if (installJavaGenerator() || ++tries > max) clearInterval(h);
    }, 50);
  }

  // Flutter에서 강제 설치 호출 가능
  window.__installJavaGenerator = installJavaGenerator;
})();