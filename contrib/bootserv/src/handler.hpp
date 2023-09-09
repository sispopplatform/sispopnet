#ifndef SISPOPNET_BOOTSERV_HANDLER_HPP
#define SISPOPNET_BOOTSERV_HANDLER_HPP
#include <iostream>
#include "sispopnet-config.hpp"

namespace sispopnet
{
  namespace bootserv
  {
    struct Handler
    {
      Handler(std::ostream& o) : out(o){};

      virtual ~Handler(){};

      /// handle command
      /// return exit code
      virtual int
      Exec(const Config& conf) = 0;

      /// report an error to system however that is done
      /// return exit code
      virtual int
      ReportError(const char* err) = 0;

     protected:
      std::ostream& out;
    };

    using Handler_ptr = std::unique_ptr< Handler >;

    /// create cgi handler
    Handler_ptr
    NewCGIHandler(std::ostream& out);

    /// create cron handler
    Handler_ptr
    NewCronHandler(std::ostream& out);

  }  // namespace bootserv
}  // namespace sispopnet

#endif
