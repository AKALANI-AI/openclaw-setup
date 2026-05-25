#!/bin/bash
echo "🔍 Verifying setup..."
PASS=0
FAIL=0

check() {
    if eval "$2" &>/dev/null; then
        echo "  ✅ $1"
        ((PASS++))
    else
        echo "  ❌ $1"
        ((FAIL++))
    fi
}

check "OpenClaw installed" "openclaw --version"
check "qmd installed" "qmd --version"
check "qmd indexed" "qmd status | grep -q 'files indexed'"
check "openclaw.json has memory backend" "python3 -c \"import json; d=json.load(open('$HOME/.openclaw/openclaw.json')); assert d.get('memory',{}).get('backend')=='qmd'\""
check "lossless-claw plugin enabled" "openclaw plugins list 2>&1 | grep -q 'lossless-claw.*enabled'"

echo ""
echo "Results: $PASS passed, $FAIL failed"
[ $FAIL -eq 0 ] && echo "🎉 All checks passed!" || echo "⚠️  Some checks failed"
