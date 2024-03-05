#ifndef FONTBIDI_H
#define FONTBIDI_H

#include <stdbool.h>
#include <stdint.h>

void bidi_init(void);
void bidi_destroy(void);
bool is_directional_character(uint32_t codepoint);
bool is_joiner(uint32_t codepoint);
bool bidi_should_transform_utf32(const bool rtl, const uint32_t* text);
const uint32_t* bidi_transform_utf32(const bool rtl, const uint32_t* text);

#endif // FONTBIDI_H
