typedef struct _VisualLayoutGlyph
{
    uint32_t out_codepoint;
    uint16_t orig_char_index;
    uint8_t glyph_width;
    bool tombstone;
    bool in_rtl_run;
} VisualLayoutGlyph;

void bidi_init(void);
void bidi_destroy(void);
bool is_directional_character(uint32_t codepoint);
bool is_joiner(uint32_t codepoint);
bool bidi_should_transform_utf32(const bool rtl, const uint32_t* text);
const uint32_t* bidi_transform_utf32(const bool rtl, const uint32_t* text, VisualLayoutGlyph* layout, size_t layout_n);
