# coding: utf-8

module Youroom
  class MarkRead < Mark
    def path
      File.join(url, 'mark_read')
    end
  end
end
