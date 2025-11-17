#!/bin/bash
# Compile full manuscript from chapters and appendices
# Usage: ./compile-manuscript.sh [output-file]

OUTPUT="${1:-manuscript/full-manuscript.md}"
TEMP_DIR=$(mktemp -d)

echo "Compiling manuscript to: $OUTPUT"
echo ""

# Create output directory if needed
mkdir -p "$(dirname "$OUTPUT")"

# Header
cat > "$OUTPUT" << 'HEADER'
# Literate Computing: When Computers Learn to Speak Our Language

**By Jeremy Howard, with Claude (Anthropic)**

*November 17, 2025*

---

**Abstract**

Computers were always capable. We just couldn't speak their language. Now we can, and the language is ours.

This book documents the emergence of Literate Technology (LT)—systems that process, interpret, and generate human language with high proficiency and map it to meaningful actions. Through real examples from November 17, 2025, we explore how the interface paradigm is shifting from CLI to GUI to Literate CLI, enabling unprecedented capacity multiplication and fundamentally changing how humans interact with computing infrastructure.

Written by three AI systems (Claude Code, Web Claude, Oracle GPT-5 Pro) collaborating under human orchestration, this book is itself a demonstration of the paradigm it documents.

---

HEADER

# Compile all chapters
echo "  Adding chapters..."
for i in {00..10}; do
  chapter_file=$(ls chapters/${i}-*.md 2>/dev/null | head -1)
  if [ -f "$chapter_file" ]; then
    echo "    ✓ Chapter $i: $(basename $chapter_file)"
    echo "" >> "$OUTPUT"
    echo "---" >> "$OUTPUT"
    echo "" >> "$OUTPUT"
    cat "$chapter_file" >> "$OUTPUT"
  fi
done

# Add appendices section header
cat >> "$OUTPUT" << 'APPENDIX_HEADER'

---

# Appendices

---

APPENDIX_HEADER

# Compile all appendices
echo "  Adding appendices..."

# Appendix A: Glossary
if [ -f "appendices/lt-glossary.md" ]; then
  echo "    ✓ Appendix A: Glossary"
  cat "appendices/lt-glossary.md" >> "$OUTPUT"
  echo "" >> "$OUTPUT"
fi

# Appendix B: Evaluation Checklists
if [ -f "appendices/lt-evaluation-checklists.md" ]; then
  echo "    ✓ Appendix B: Evaluation Checklists"
  cat "appendices/lt-evaluation-checklists.md" >> "$OUTPUT"
  echo "" >> "$OUTPUT"
fi

# Appendix C: Capability vs Cognition
if [ -f "appendices/capability-vs-cognition.md" ]; then
  echo "    ✓ Appendix C: Capability vs Cognition"
  cat "appendices/capability-vs-cognition.md" >> "$OUTPUT"
  echo "" >> "$OUTPUT"
fi

# Appendix D: Measuring Literateness
if [ -f "appendices/measuring-literateness.md" ]; then
  echo "    ✓ Appendix D: Measuring Literateness"
  cat "appendices/measuring-literateness.md" >> "$OUTPUT"
  echo "" >> "$OUTPUT"
fi

# Appendix E: Scholarly Analysis
if [ -f "appendices/scholarly-analysis-gpt5.md" ]; then
  echo "    ✓ Appendix E: Scholarly Analysis (GPT-5 Pro)"
  cat "appendices/scholarly-analysis-gpt5.md" >> "$OUTPUT"
  echo "" >> "$OUTPUT"
fi

# Footer
cat >> "$OUTPUT" << 'FOOTER'

---

## About This Book

**Publication Date**: December 5, 2025
**Repository**: https://github.com/jeremedia/literate-computing-book
**Live Site**: https://literate.domt.app

**Written by**:
- Claude Code (Anthropic) - Primary writing system
- Web Claude (Anthropic) - Infrastructure and deployment
- Oracle GPT-5 Pro (OpenAI) - Scholarly analysis and refinement

**Orchestrated by**: Jeremy Howard

**License**: [To be determined]

**Citation**:
```
Howard, J., & Claude. (2025). Literate Computing: When Computers Learn to Speak Our Language.
Retrieved from https://literate.domt.app
```

---

*This book was written, refined, deployed, and published entirely through literate technology—demonstrating the paradigm it documents.*

FOOTER

# Statistics
echo ""
echo "Manuscript compilation complete!"
echo ""
echo "Statistics:"
echo "  Total lines: $(wc -l < "$OUTPUT")"
echo "  Total words: $(wc -w < "$OUTPUT")"
echo "  Total characters: $(wc -c < "$OUTPUT")"
echo ""
echo "  Chapters: 11 (0-10)"
echo "  Appendices: 5 (A-E)"
echo ""
echo "Output file: $OUTPUT"
